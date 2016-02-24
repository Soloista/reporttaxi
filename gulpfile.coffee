gulp = require 'gulp'
util = require 'gulp-util'
uglify = require 'gulp-uglify'
concat = require 'gulp-concat'
coffee = require 'gulp-coffee'
sass = require 'gulp-sass'
minify = require 'gulp-minify-css'
cached = require 'gulp-cached'
notify = require 'gulp-notify'
shell = require 'gulp-shell'
electron = require 'gulp-atom-electron'
zip = require 'gulp-vinyl-zip'
symdest = require 'gulp-symdest'

gulp.task 'debug', shell.task [
    'electron www/'
]

gulp.task 'main', ()->
    gulp.src 'templates/main/main.coffee'
        .pipe cached 'index-coffee-converter'
        .pipe coffee {bare: true}
#        .pipe uglify()
        .pipe gulp.dest 'www/'
        .pipe notify 'Done on converting the main index.'

gulp.task 'js', ()->
    gulp.src 'templates/coffee/*.coffee'
        .pipe cached 'coffee-converter'
        .pipe coffee {bare: true}
        .pipe uglify()
        .pipe gulp.dest 'www/js/'
        .pipe notify 'Done on converting coffeescript to javascript.'

gulp.task 'css', ()->
    gulp.src 'templates/sass/*.sass'
        .pipe cached 'sass-converter'
        .pipe sass()
        .pipe minify()
        .pipe gulp.dest 'www/css/'
        .pipe notify 'Done on converting sass to css.'

gulp.task 'download-electron-win32', ()->
    electron.dest 'electron-build', {version: '0.36.7', platform: 'win32', arch: 'ia32'}

gulp.task 'download-electron-win64', ()->
    electron.dest 'electron-build', {version: '0.36.7', platform: 'win32', arch: 'x64'}

gulp.task 'download-electron-linux64', ()->
    electron.dest 'electron-build', {version: '0.36.7', platform: 'linux', arch: 'x64'}

gulp.task 'build-linux', ()->
    gulp.src 'www/**'
        .pipe electron {version: '0.36.7', platform: 'linux', arch: 'x64'}
        .pipe zip.dest 'build/linux/app-linux.zip'

gulp.task 'build-win64', ()->
    gulp.src 'www/**'
    .pipe electron {version: '0.36.7', platform: 'win32', arch: 'x64'}
    .pipe zip.dest 'build/win64/app-win64.zip'

gulp.task 'build-win32', ()->
    gulp.src 'www/**'
        .pipe electron {version: '0.36.7', platform: 'win32', arch: 'ia32'}
        .pipe zip.dest 'build/win32/app-win32.zip'

gulp.task 'build-win32-trap', ()->
    gulp.src 'www/**'
    .pipe electron {version: '0.36.7', platform: 'win32', arch: 'ia32'}
    .pipe zip.dest 'build/win32/app-win32-beta.zip'

gulp.task 'clear-cache', ()->
    cached.caches = {}

gulp.task 'default', ()->
    gulp.watch 'templates/main/main.coffee', ()->
        gulp.start 'main'
    gulp.watch 'templates/coffee/*.coffee', ()->
        gulp.start 'js'
    gulp.watch 'templates/sass/*.sass', ()->
        gulp.start 'css'