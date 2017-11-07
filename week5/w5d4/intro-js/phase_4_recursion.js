const NUMS = [1,2,3,4,5]

function range(start, end) {
  if (start === end) {
    return []
  } else {
    return [start] + range(start + 1, end)
  }
}

// console.log(range(1,5))

function sumRec(arr) {
  if (arr.length === 0) {
    return 0
  } else {
    return arr[arr.length - 1] + sumRec(arr.slice(0, arr.length - 1))
  }
}

// console.log(`sumRec([1, 3, 5]) = ${sumRec([1, 3, 5])}`);

function exponent(base, exp) {
  if (exp === 1) {
    return base
  } else
  return base + exponent(base, exp - 1)
}

// console.log(exponent(2,4))

// function fibonacci(n) {
//   if (n === 0) {
//     return []
//   } else if (n === 1) {
//     return [1]
//   } else if (n === 2) {
//     return [1,1]
//   } else {
//     f = fibonacci(n - 1)
//     next = f[f.length - 1] + f[f.length - 2]
//     console.log(f)
//     return f.push(next)
//   }
// }

function fibit(n) {
  var result = [1,1]
  while (result.length < n) {
    result.push(result[result.length - 1] + result[result.length - 2])
  }
  return result
}

function fibsRec(n) {
  if (n < 3) {
    return [0,1].slice(0, n);
  }
  let fib = fibsRec(n - 1);
  fib.push(fib[fib.length - 1] + fib[fib.length - 2]);
  return fib;
}

// console.log(fibsRec(3));

function bSearch(numbers, target) {
  if (numbers.length === 0) {
    return -1;
  }

  const probeIdx = Math.floor(numbers.length / 2);
  const probe = numbers[probeIdx];

  if (probe === target) {
    return probeIdx;
  } else if (target < probe) {
    let left = numbers.slice(0, probeIdx);
    return bSearch(left, target);
  } else if (target > probe) {
    let right = numbers.slice(probeIdx + 1, numbers.length);
    const sub = bSearch(right, target);

    return sub === -1 ? -1 : sub + probeIdx + 1
  }
}

// console.log(bSearch([1,2,3,6,7,8,9,10], 9));

function mergesort(arr) {
  if (arr.length <= 1) {
    return arr;
  }
  const mid = Math.floor(arr.length / 2);
  const left = mergesort(arr.slice(0,mid));
  const right = mergesort(arr.slice(mid));
  return merge(left, right);
}

function merge(arr1, arr2) {
  let result = []
  while (arr1.length > 0 && arr2.length > 0) {
    if (arr1[0] < arr2[0]) {
      result.push(arr1[0])
      arr1 = arr1.slice(1)
    } else {
      result.push(arr2[0])
      arr2 = arr2.slice(1)
    }
  }
  return result.concat(arr1, arr2)
}

// console.log(mergesort([9,3]))
// console.log(mergesort([3,5,7,8,9,2,4,5,7,1,23,1]))
