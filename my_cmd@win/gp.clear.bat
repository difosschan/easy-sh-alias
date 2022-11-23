@rem 保留记录图片URL的txt文档
xfind -type f -name "http*" -print0 |grep -azvE ".*\.txt$" |xargs -0 rm -rf
