def fibs(n)

  fibArray = [0,1]

  (n-2).times do
    fibArray << fibArray[-1] + fibArray [-2]
  end

  fibArray
end
# All 3 fibs_rec below do the same thing.  The first one is more readable and is
# efficient.  The second two are showing it can be done in 2 or 1 lines.
# The last one is showing you one line less than 80 characters long.
# The last two take MUCH longer to run so aren't recommended for higher values!
def fibs_rec(n)
  if n <= 2 then return n == 2  ? [0,1] : [0] end
  a = fibs_rec(n-1)
  return a << a[-1] + a[-2]

end

def fibs_rec_2(n)
  if n <= 2 then return n == 2  ? [0,1] : [0] end
  return fibs_rec_2(n-1) << fibs_rec_2(n-1)[-1] + fibs_rec_2(n-1)[-2]

end

def fibs_1(n)
  n <= 2  ? [0,1][0..n-1] :  fibs_1(n-1) << fibs_1(n-1)[-1] + fibs_1(n-1)[-2]
end
