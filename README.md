# ShellMyth
学习好Shell编程核心： 多练-----多思考 -----再练 -----再思考
工作地位： 适用于处理 **纯文本类型** 的数据
Shell 中特殊且重要的变量
| 位置变量|作用说明|
|--------|:------:|
| $0    | 获取当前执行Shell脚本的文件名 |
| $n    | 获取执行的Shell 脚本的第n个参数，n=1..9, 大于9，用大括号括起来 |
| $#    | 获取当前执行的 Shell 脚本后面的参数的总数|
| $*    | 获取当前shell 脚本所有传参的参数，不加引号和$@相同；“$*",则表示将所有的参数视为单个字符串， |
| $@    | 获取当前shell 脚本所有传参的参数，"$@",则表示将所有的参数视为不同的独立字符串， 相当于 "$1", "$2"..... |
| $?    | 获取执行上个指令的执行状态返回值（0为成功，非零为失败)   
| $$    | 获取当前执行的 Shell 脚本的进程号（PID) |
| $!    | 获取上一个在后台工作的进程的进程号（PID) |
| $_    | 获取在此之前执行的命令或者脚本的最后一个参数 |
## Shell 变量子串说明
|ID|表达式|说明|
|--------|:-------:|:------:|
| 1 |${parameter}                 | 返回变量$parameter 的内容|
| 2 |${#parameter}                | 返回变量 $parameter 内容的长度（按字符）， 也适用于特殊变量 |
| 3 |${parameter:offset}          | 在变量 ${parameter}中， 从位置 offset 之后开始提取子串到结尾 |
| 4 |${parameter:offset:length}   | 在变量 ${parameter}中， 从位置 offset 之后开始提取长度为length的子串 |
| 5 |${parameter#word}            | 从变量 ${parameter} 开头开始删除最短匹配的word 子串|
| 6 |${parameter##word}           | 从变量 ${parameter} 开头开始删除最长匹配的 word 子串 |
| 7 |${parameter%word}            | 从变量 ${parameter} 结尾开始删除最短匹配的word 子串|
| 8 |${parameter%%word}           | 从变量 ${parameter} 结尾开始删除最长匹配的 word 子串 |
| 9 |${parameter/pattern/string}  | 使用string 替换第一个匹配的pattern              |
| 10|${parameter//pattern/string} | 使用string 替换所有匹配的pattern              |
| 11|${parameter:-word}           | 如果 parameter的变量值为空或未赋值，则会返回 word 字符串并代替变量的值，用途：如果变量未定义，则返回备用的值，防止变量为空值或因未定义而导致异常|
| 12|${parameter:=word}           | 如果 parameter的变量值为空或未赋值，则会返回 word 字符串并代替变量的值，用途: 同上一个，但该变量又额外给parameter 变量赋值|
| 13|${parameter:?word}           | 如果 parameter的变量值为空或未赋值，那么word 字符串将被作为标准错误输出，否则输出变量值 ，用途：捕捉由于变量未定义而导致的错误，并退出程序|
| 14|${parameter:+word}           | 如果 parameter的变量值为空或未赋值，则什么都不做， 否则word字符串将替代变量的值|

 



## Linux 正则表达式
## 三剑客  grep、 awk 、 sed

## 实例


[My github]: https://github.com/linleijava/ "git"
