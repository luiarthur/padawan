import scala.io.Source
import java.io.File // write to file. new File("file.txt")
import scala.util.Random

// put breeze.jar in the scala lib
import breeze.linalg._
import breeze.linalg.{DenseMatrix=>dmat,DenseVector=>dvec}
import breeze.numerics._
import breeze.stats.distributions._
import breeze.stats.mean

object bayesMLR{
  // Objects
  val afile = new File("../data/dat.txt")
  val G = Gaussian(0,1)
  val U = new Random // U.nextDouble

  // Other Constants
  val m = csvread(afile,' ') //requires breeze.linalg
  val n = m.rows
  val k = m.cols-1

  val X = m(::,1 to k)
  val Xt = X.t
  val XXi = inv(Xt*X)
  val y = m(::,0)
  val s2 = 10.0
  val a = 1.0
  val b = 1.0
  val B = 100000
  val keep = 10000
  // Candidate Sigmas:
  val csb = XXi(::,*) * 4.0
  val css = 1.0
  // Acceptance Counters:
  var accb, accs = 0

  def ll(be: dvec[Double], sig2: Double): Double = {
    val c = y - X * be
    val out = (c.t*c/sig2 + n*log(sig2)) / -2.0
    out
  }

  def lpb(be: dvec[Double]): Double = be.t*XXi*be / (-2.0*s2)
  def lps(sig2: Double): Double = (a-1)*log(sig2) - sig2/b
  def mvrnorm(M: dvec[Double], S: dmat[Double]): dvec[Double] =
    M + cholesky(S) * G.samplesVector(k)
    // cholesky returns lower triangle: m + Lz is what we want

  // Update Functions:
  def update_beta(curr_beta: dvec[Double], curr_sig2: Double): dvec[Double] = {
    val cand_beta = mvrnorm(curr_beta,csb)
    val q = ll(cand_beta,curr_sig2)+lpb(cand_beta) - ll(curr_beta,curr_sig2)-lpb(curr_beta)
    if (q > U.nextDouble) { accb += 1; cand_beta } else curr_beta
  }
  def update_sig2(curr_beta: dvec[Double], curr_sig2: Double): Double = {
    val cand_sig2 = G.draw * sqrt(css) + curr_sig2
    if (cand_sig2 > 0) {
      val q = ll(curr_beta,cand_sig2)+lps(cand_sig2) - ll(curr_beta,curr_sig2)-lps(curr_sig2)
      if (q > U.nextDouble) {accs += 1; cand_sig2} else curr_sig2
    } else curr_sig2
  }

  def mh(i: Int, beta: List[dvec[Double]], sig2: List[Double]): (List[dvec[Double]], List[Double]) = {
    if (i == B) {
      (beta, sig2)
    } else {
      if (i % (B/10) == 0) print("\rProgress: "+round(i*100.0/B)+"%")
      val new_beta = update_beta(beta.head, sig2.head) :: beta
      val new_sig2 = update_sig2(new_beta.head, sig2.head) :: sig2
      mh(i+1, new_beta, new_sig2)
    }
  }

  def main(args: Array[String]) = {
    println("\nStarting...") // Takes about 2 seconds to compile, and 7 seconds to run.

    val t1 = System.currentTimeMillis / 1000.0
    val out = mh(0, List(dvec.zeros[Double](k)), List(1.0))
    val t2 = System.currentTimeMillis / 1000.0

    val beta_post = out._1.dropRight(B-keep)
    val sig2_post = out._2.dropRight(B-keep)

    println("Acceptance beta: " + 100.0*accb/B+"%")
    println("Acceptance sig2: " + 100.0*accs/B+"%\n")

    println("Posterior mean sig2: " + sig2_post.reduce(_+_) / keep)
    println("Posterior mean beta:")
    (beta_post.reduce(_+_) / dvec.fill(k)(keep*1.0)).foreach(println)

    println("Gibbs Time: "+ round( (t2-t1)*10 ) / 10.0 +"s\n")
  }
}
//see: http://github.com/luiarthur/progSpeedCompare/tree/master/scala_functional
