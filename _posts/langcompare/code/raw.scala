package functionalBayesMLR

object bayesMLR {
  import scala.io.Source
  import java.io.File // write to file. new File("file.txt")
  import breeze.linalg._
  import breeze.linalg.{DenseMatrix=>dmat,DenseVector=>dvec}
  import breeze.numerics._
  import breeze.stats.distributions._ // 1 draw: Dist.draw. n draws: Dist.sample(n)
  import breeze.stats.mean

  class State(val beta: dvec[Double], val s2: Double)
  val afile = new File("../data/dat.txt")
  val dat = csvread(afile,' ') //requires breeze.linalg
  val G = Gaussian(0,1)
  val U = Uniform(0,1)

  val (n,k) = (dat.rows, dat.cols-1)

  val y = dat(::,0)
  val X = dat(::,1 to k)
  val Xt = X.t
  val XXi = inv(Xt*X)
  val s2 = 10.0
  val a = 1.0
  val b = 1.0
  val B = 100000
  val keep = 10000
  val burn = B - keep
  val csb = XXi(::,*) * 4.0
  val S = cholesky(csb)
  val css = 1.0
  var accb, accs = 0

  def ll(be: dvec[Double], sig2: Double): Double = {
    val c = y - X * be
    (c.t*c/sig2 + n*log(sig2)) / -2.0
  }

  def lpb(be: dvec[Double]): Double = be.t*XXi*be / (-2.0*s2)
  def lps(sig2: Double): Double = (a-1)*log(sig2) - sig2/b
  def mvrnorm(m: dvec[Double]) = m + S*G.samplesVector(k)

  // Update Functions:
  def update_State(s: State): State = {

    // Update beta
    val b_cand = mvrnorm(s.beta)
    val q = ll(b_cand,s.s2)+lpb(b_cand) - ll(s.beta,s.s2)-lpb(s.beta)
    val beta_new = if (q > log(U.draw)) { accb += 1; b_cand} else s.beta

    // Update s2
    val s2_cand= G.draw * sqrt(css) + s.s2
    val s2_new = if (s2_cand> 0) {
      val q = ll(beta_new, s2_cand)+lps(s2_cand) - ll(beta_new, s.s2)-lps(s.s2)
      if (q > log(U.draw)) {accs += 1; s2_cand} else s.s2
    } else s.s2

    new State( beta_new, s2_new )
  }

  def mh(i: Int, S: List[State]): List[State] = {
    if (i < B) {
      if (i % (B/10) == 0) print("\rProgress: "+round(i*100.0/B)+"%")
      val new_State = update_State(S.head) :: S
      mh(i+1, new_State)
    } else S.dropRight(burn)
  }

  def main(args: Array[String]) = {
    val out = cool.timer { mh(1, List(new State(dvec.zeros[Double](k), 1.0))) }
    val (beta_post, sig2_post) = out.map(s => (s.beta, s.s2)).unzip

    println("Acceptance beta: " + 100.0 * accb/B+"%")
    println("Acceptance sig2: " + 100.0 * accs/B+"%\n")
    println("Posterior mean sig2: " + sig2_post.reduce(_+_) / keep)
    println("Posterior mean beta:" )
    (beta_post.map(x => x / keep.toDouble).reduce(_+_)).foreach(println)
  }
} //see: http://github.com/luiarthur/progSpeedCompare/tree/master/scala_functional
