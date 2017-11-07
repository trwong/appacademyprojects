// Array.prototype.uniq = function() {
//   let result = [];
//   for (let i = 0; i < this.length; i++) {
//     if (result.indexOf(this[i]) === -1) {
//       result.push(this[i])
//     }
//   }
//   return result;
// }
//
// console.log([1,1,1,2,2,3,4,5,5,6].uniq());
//
//
// Array.prototype.twoSum = function() {
//   let result = []
//   for (let i = 0; i < this.length - 1; i++) {
//     for (let j = i + 1; j < this.length; j++) {
//       if (this[i] + this[j] === 0) {
//         result.push([i, j])
//       }
//     }
//   }
//   return result
// }
//
// console.log([0,1,2,3,4,5,-2,-1].twoSum());

Array.prototype.transpose = function() {
  let result = []
  for (let i = 0; i < this.length; i++) {
    result.push([])
    for (let j = 0; j < this.length; j++) {
      result[i][j] = this[j][i]
    }
  }
  return result
}

console.log([[1,2],[3,4]].transpose())
