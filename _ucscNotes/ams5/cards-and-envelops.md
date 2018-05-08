---
title: "Cards and Envelops (AMS 131)"
date: 2018-05-08
comments: disqus
ams: 5
---

# Problem 1
Suppose that 10 cards, of which seven are red and three are green, are put at random
into 10 envelops, of which seven are red and three are green, so that each envelop contains
one card. Determine the probability that exactly $k$ envelops will contain a card with a matching
color ($k=0,1,2,...,10$).

**Hint:** First find the probability that exactly $r$ red envelops will contain a red card.

**Solution:** We will first compute the probability that exactly $r$ red envelops will
contain a red card. Since there seems to be several moving quantities, imagine the scenario 
where you already have the seven red cards in your hands. You will then pick seven envelops
at random from the 10 envelops you have. Then, you will put the seven red cards in your hand
into the seven envelops that you just randomly selected. This is actually the scenario we
are given in the problem (convince yourself this is the case).

Now, to compute the probability of $r$ red matches, we need to compute 

1. The number of ways to select (7) envelops to place our (7) red cards. (Denominator)
    - This is just ${10 \choose 7}$. We are choosing 7 envelops from the 10 available.
2. The number of ways to select ($r$) red envelops for our (7) red cards. (Numerator)
    - This is just ${7 \choose r}$. We are choosing $r$ red envelops from the red envelops available.
3. The number of ways to select ($7-r$) green envelops for our (7) red cards. (Numerator)
    - This is just ${3 \choose 7-r}$. We are choosing $7-r$ green envelops from the green envelops available.

Note that we need to select 7 envelops, because we have 7 red cards. And if we
selected $r$ red envelops, then we implicitly selected $7-r$ green envelops.

So, the probability of $r$ red matches is
$$
P(R=r) = {7 \choose r}{3 \choose 7-r} / {10 \choose 7}.
$$
But note that $r$ is restricted to a range of possible values. For example, if $r>7$ or $r<3$
then ${3 \choose 7-r}$ will be undefined. So, $r$ is restricted to $r=3,4,5,6,7$. And $P(R=r)$
for any other value is $0$.

However, this is not the quantity we are interested in. We are interested in the probability
of $k$ total matches. Notice that if there are $r$ red matches, then there must be $r-4$ green 
matches. This is best illustrated with a table.

|                 | Red Envelops  | Green Envelops | sum |
| -------------   |:-------------:|:--------------:|:---:|
| **Red Cards**   | $r$           | ???            | 7   |
| **Green Cards** | ???           | ???            | 3   |
| **sum**         | 7             | 3              | 10  |

From this table, if we have $r$ red cards in red envelops. Then what is the
number of green cards in green envelops? Well, we know that there are in total
seven red envelops and three green envelops (column sums). We also know that
there are in total five red cards and five green cards (row sums). So, there
must be $7-r$ green envelops containing red cards. Similarly, I can solve for
the number of red envelops containing green cards to be $7-r$. Now, if I have
$7-r$ green cards in red envelops, and I have 3 green cards in total, I know I
must have $3 - (7-r) = r-4$ green cards in green envelops. The updated table
is then the following.

|                 | Red Envelops  | Green Envelops | sum |
| -------------   |:-------------:|:--------------:|:---:|
| **Red Cards**   | $r$           | $7-r$          | 7   |
| **Green Cards** | $7-r$         | $\mathbf{r-4}$ | 3   |
| **sum**         | 7             | 3              | 10  |

So, $r$ red matches implies $r$ red matches and $r-4$ green matches, which is 
$r + r-4 = 2r - 4$ total matches. 

Finally, note that it is not possible to have an odd number of matches because
$2r-4$ is even. In fact, the possible total number of matches is only
$\bc{2r-4}, \text{ for } r=3,4,5,6,7$, which is $\bc{2,4,6,8,10}$.  If we let
$k$ be the number of matches, then $P(K=k)=P(R=(k+4)/2)$, for $k=2,4,6,8,10$.
$P(K=k)$ for any other $k$ is 0.

---

# Problem 2
Suppose that 10 cards, of which five are red and five are green, are put at random
into 10 envelops, of which seven are red and three are green, so that each envelop contains
one card. Determine the probability that exactly $k$ envelops will contain a card with a matching
color ($k=0,1,2,...,10$).

**Hint:** First find the probability that exactly $r$ red envelops will contain a red card.

**Solution:** The process is the same as above.

We will first compute the probability that exactly $r$ red envelops will
contain a red card. Since there seems to be several moving quantities, imagine
the scenario where you already have the seven red cards in your hands. You will
then pick five envelops at random from the 10 envelops you have. Then, you
will put the five red cards in your hand into the five envelops that you just
randomly selected. This is actually the scenario we are given in the problem
(convince yourself this is the case).

Now, to compute the probability of $r$ red matches, we need to compute 

1. The number of ways to select (5) envelops to place our (5) red cards. (Denominator)
    - This is just ${10 \choose 5}$. We are choosing 5 envelops from the 10 available.
2. The number of ways to select ($r$) red envelops for our (5) red cards. (Numerator)
    - This is just ${7 \choose r}$. We are choosing $r$ red envelops from the red envelops available.
3. The number of ways to select ($5-r$) green envelops for our (5) red cards. (Numerator)
    - This is just ${3 \choose 5-r}$. We are choosing $5-r$ green envelops from
      the green envelops available.

Note that we need to select 5 envelops, because we have 5 red cards. And if we
selected $r$ red envelops, then we implicitly selected $5-r$ green envelops.

So, the probability of $r$ red matches is
$$
P(R=r) = {7 \choose r}{3 \choose 5-r} / {10 \choose 5}.
$$
But note that $r$ is restricted to a range of possible values. For example, if $r>5$ or $r<2$
then ${3 \choose 5-r}$ will be undefined. So, $r$ is restricted to $r=2,3,4,5$. And $P(R=r)$
for any other value is $0$.

However, this is not the quantity we are interested in. We are interested in the probability
of $k$ total matches. Notice that if there are $r$ red matches, then there must be $r-2$ green 
matches. This is best illustrated with a table.

|                 | Red Envelops  | Green Envelops | sum |
| -------------   |:-------------:|:--------------:|:---:|
| **Red Cards**   | $r$           | ???            | 5   |
| **Green Cards** | ???           | ???            | 5   |
| **sum**         | 7             | 3              | 10  |

From this table, if we have $r$ red cards in red envelops. Then what is the
number of green cards in green envelops? Well, we know that there are in total
seven red envelops and three green envelops (column sums). We also know that
there are in total seven red cards and three green cards (row sums). So, there
must be $5-r$ green envelops containing red cards. Similarly, I can solve for
the number of red envelops containing green cards to be $7-r$. Now, if I have
$7-r$ green cards in red envelops, and I have 5 green cards in total, I know I
must have $5 - (7-r) = r-2$ green cards in green envelops. The updated table
is then the following.

|                 | Red Envelops  | Green Envelops | sum |
| -------------   |:-------------:|:--------------:|:---:|
| **Red Cards**   | $r$           | $5-r$          | 5   |
| **Green Cards** | $7-r$         | $\mathbf{r-2}$ | 5   |
| **sum**         | 7             | 3              | 10  |

So, $r$ red matches implies $r$ red matches and $r-2$ green matches, which is 
$r + r-2 = 2r - 2$ total matches. 

Finally, note that it is not possible to have an odd number of matches because
$2r-2$ is even. In fact, the possible total number of matches is only
$\bc{2r-2}, \text{ for } r=2,3,4,5$, which is $\bc{2,4,6,8}$.  If we let
$k$ be the number of matches, then $P(K=k)=P(R=(k+2)/2)$, for $k=2,4,6,8$.
$P(K=k)$ for any other $k$ is 0.


