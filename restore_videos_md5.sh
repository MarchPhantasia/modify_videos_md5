#!/bin/bash
# script.sh

#===============================================================================#
# 用途：恢复所有该脚本所在目录下所有文件的md5，需与modify_videos_md5.sh搭配使用。
#===============================================================================#

# 获取该脚本所在的目录路径
script_dir=$(dirname $0)

# 防止文件名中有空格
OLD_IFS=$IFS
IFS=$'\n'

# 函数：遍历当前目录下所有文件，如果该文件不是目录，若该文件最后一行的前缀是"#1024"，则删除该行。
function delete_last_string_from_file() {
    for file in $(ls); do
        echo $file
        if [ -f $file ]; then
            # 获取文件最后一行
            last_line=$(tail -n 1 $file)
            echo $last_line
            
            # 判断文件最后一行是否以"#1024"开头
            if [[ $last_line =~ ^#1024 ]]; then
                # 删除文件以"#1024"开头的最后一行
                # sed -i '' '$d' $file  # MMac 环境下 shell 的 sed 命令有坑，-i  后面必须加 ''
                # 删除末尾的换行符
                # sed -i '' '/^$/d' $file

                # 将最后一行替换为空
                sed -i '' '$s/$/ /' $file
            fi
        fi
    done
}

delete_last_string_from_file

# 恢复IFS
IFS=$OLD_IFS 