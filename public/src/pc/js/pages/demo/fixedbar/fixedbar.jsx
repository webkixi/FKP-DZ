var FixedBar = require('modules/fixed/fixedbar'),
render = React.render;


//循环数据
render(
  <FixedBar left={'10px'} top={'100px'}>
      <div id={'test'} style={{'backgroundColor':'blue','height':'300px','width':'100px'}}>123</div>
  </FixedBar>
  ,document.getElementById('good')
);



module.exports = {};


//参考
// from http://jsfiddle.net/aabeL/1/
// https://github.com/jeroencoumans/react-scroll-components
// https://github.com/guillaumervls/react-infinite-scroll
// http://levi.cg.am/archives/3099   //getBoundingClientRect
//
// http://www.cnblogs.com/dingyingsi/archive/2013/09/24/3337813.html   scrollHeight
