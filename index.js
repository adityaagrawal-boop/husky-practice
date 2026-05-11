const user = { name: 'Drashti', age: 25, city: 'India' };
function sayHi(name) {
  return 'Hello ' + name;
}
const mess = sayHi(user?.name);
console.log(mess);
