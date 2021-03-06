fs = require('fs')
path = require('path')
gulp = require('gulp')
gutil = require('gulp-util')
configs = require './config'
slime = require('./_builder/configs/slime.config.js')

browserSync = require 'browser-sync'
reload = browserSync.reload
env = 'dev'

# Load plugins
$ = require('gulp-load-plugins')()

# 初始化生成临时目录
tmpDir = './dist/_tmp'
if !fs.existsSync('./dist')
   fs.mkdirSync('./dist')
   if  !fs.existsSync(tmpDir)
       fs.mkdirSync(tmpDir);

getTask = (task,env)->
    if !env
        env = 'dev'

    require('./_builder/gulp-task/'+task)(gulp, $, slime, env)

# 清理dist/目录
gulp.task 'clean:build', getTask('clean-build')

# 清理dist/dev目录
gulp.task 'clean:dev', getTask('clean-dev')

# 合并ie8需要的脚本依赖
gulp.task 'ie:dev', getTask('ie')

# common.css
gulp.task 'commoncss:dev', getTask('css-common')

# page.css  合并雪碧图
# gulp.task 'pagecss:dev', getTask('css-pages')
gulp.task 'pagecss:dev',['commoncss:dev','images:dev'], getTask('css-pages')

# 对图像资源复制至dist
gulp.task 'images:dev', getTask('images-dev')

gulp.task 'images:build', ['pagecss:dev'], getTask('images-build')

# 对字体图标资源复制至dist
gulp.task 'fonts:dev', getTask('fonts-dev')

gulp.task 'fonts:build', getTask('fonts-build')

# 对静态页面进行编译
gulp.task 'html', getTask('html')  #webpack解析
gulp.task 'html:build', getTask('html','pro') #交由服务器端解析

# 拷贝如编辑器这样的无法分解的前端js
gulp.task 'copyThirdJsToDist:dev', ['copyThirdCssToDist:dev'], getTask('js-copy2-dev')
gulp.task 'copyThirdJsToDist:pro', ['copyThirdCssToDist:pro'], getTask('js-copy2-build')

# 拷贝如组件（JS + CSS）类似的CSS
gulp.task 'copyThirdCssToDist:dev', getTask('css-copy2-dev')
gulp.task 'copyThirdCssToDist:pro', getTask('css-copy2-build')

# 生成API文档，有待改良
gulp.task 'doc', getTask('doc')

#本地资源静态DEMO服务器/代理动态(koajs)服务器
gulp.task "server", ['buildCommon:dev','html','ie:dev','fonts:dev','pagecss:dev','copyThirdJsToDist:dev'] , getTask('server')  # for demo
gulp.task "dev", ['buildCommon:dev','ie:dev','fonts:dev','pagecss:dev','copyThirdJsToDist:dev'] , getTask('server','pro')  # for dev and pro
gulp.task "ngdev", ['buildCommon:dev:ng','ie:dev','fonts:dev','pagecss:dev','copyThirdJsToDist:dev'] , getTask('server','ngpro')  # for angular dev and pro
gulp.task "ng", ['buildCommon:dev:ng','ie:dev','fonts:dev','pagecss:dev','copyThirdJsToDist:dev'] , getTask('server','ng')  # for demo and angular
gulp.task "bbdev", ['buildCommon:dev:bb','html','ie:dev','fonts:dev','pagecss:dev','copyThirdJsToDist:dev'] , getTask('server','bbpro')  # for backbone dev and pro
gulp.task "bb", ['buildCommon:dev:bb','html','ie:dev','fonts:dev','pagecss:dev','copyThirdJsToDist:dev'] , getTask('server','bb')  # for demo and backbone

# js/pages编译并生成_common.js
gulp.task 'wp:dev', getTask('wp')

# 默认启动本地DEMO服务器
gulp.task 'default',['clean:dev'], ->
    gulp.start 'server'

# 构建任务，生成未压缩版
gulp.task 'buildCommon:dev',['wp:dev'], getTask('concat-common-js')
gulp.task 'buildCommon:dev:ng',['wp:dev'], getTask('concat-common-js','ng')
gulp.task 'buildCommon:dev:bb',['wp:dev'], getTask('concat-common-js','bb')

# 构建任务，生成压缩版与未压缩版
gulp.task 'build',['clean:dev','clean:build'], getTask('map','pro')

gulp.task 'testserver',['build'], getTask('server-pro')

gulp.task 'concat', getTask('concat-common-js')

gulp.task 'ser', getTask('server')

gulp.task 'watch', getTask('watch')
gulp.task 'watch:pro', getTask('watch','pro')
gulp.task 'watch:bb', getTask('watch','bb')
gulp.task 'watch:ng', getTask('watch','ng')
