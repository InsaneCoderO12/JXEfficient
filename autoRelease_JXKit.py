# -*- coding: utf-8 -*-
import os
import sys

if sys.getdefaultencoding() != 'utf-8':
    reload(sys)
    sys.setdefaultencoding('utf-8')

#

project_path = "%s/Desktop/GitHub/JXKit" % os.environ['HOME']

proj_name = "JXKit"
pod_Spec_Repo = "JXSpecRepo"


log_pre_success = "✅ =====>"
log_pre_failure = "❌ =====>"


# 增加组件版本号
def add_version():
    os.chdir("%s" % project_path)

    # 检查本地仓库是否修改
    status = os.popen("git status").read()
    if "nothing to commit" in status: # 当前 仓库 状态无修改
        print("%s %s" % (log_pre_failure, status))
        # return

    # 获取当前 仓库 的最新版本
    tag_old = os.popen("git describe --tags `git rev-list --tags --max-count=1`").read().replace("\n", "")

    ver_components = tag_old.split('.')
    ver_components[-1] = str(int(ver_components[-1]) + 1)
    tag_new = '.'.join(ver_components)

    # 修改组件配置文件版本号
    filePath = "%s/%s.podspec" % (project_path, proj_name)
    open_r = open(filePath, 'r')
    content = open_r.read()
    content = content.replace(tag_old, tag_new)

    open_w = open(filePath, 'w')
    open_w.write(content)
    open_w.close()

    push_git(tag_new)

#
def push_git(tag_new):
    # 提交当前修改
    os.chdir("%s" % project_path)
    os.system("git add -A")
    os.system("git commit -m \"push by autoRelease.py\"")
    os.system("git push origin master")

    # 创建 tag
    os.system("git tag %s" % (tag_new))
    os.system("git push --tags")

    pod_repo_push()

#
def pod_repo_push():
    # 发布组件版本
    os.system("pod repo push %s %s.podspec --use-libraries --allow-warnings" % (pod_Spec_Repo, proj_name))

#
def main():
    add_version()


#
main()
