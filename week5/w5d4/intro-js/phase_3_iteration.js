Array.prototype.bubbleSort = function() {
  var sorted = false
  while (!sorted) {
    sorted = true
    for (let i = 0; i < this.length - 1; i++) {
      for (let j = i + 1; j < this.length; j++) {
        if (this[j] < this[i]) {
          sorted = false
          let temp = this[i]
          this[i] = this[j]
          this[j] = temp
        }
      }
    }
  }
  console.log(this)
  return this
}

const NUMS = [5, 4, 3, 2, 1]

// NUMS.bubbleSort()


String.prototype.substrings = function() {
  let result = []
  for (let i = 0; i < this.length - 1; i++) {
    for (let j = i+ 1; j <= this.length; j++) {
      result.push(this.slice(i,j))
    }
  }
  console.log(result)
  return result
}

"abc".substrings()
