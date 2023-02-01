import os
from interpret import preserve

def ebm_preserve_hist(obj, dir_name):
    os.makedirs(f'./outputs/{dir_name}/', exist_ok=True)
    preserve(obj, file_name=f'outputs/{dir_name}/global.html')
    for i in obj.selector.Name:
        preserve(obj, i, file_name=f'outputs/{dir_name}/local-{i}.html')
    

def ebm_preserve_global(obj, dir_name):
    os.makedirs(f'./outputs/{dir_name}/', exist_ok=True)
    preserve(obj, file_name=f'outputs/{dir_name}/global.html')
    for i in range(len(obj.selector)):
        preserve(obj, i, file_name=f'outputs/ebm_global/global-{obj.feature_names[i]}.html')
    

def ebm_preserve_local(obj, dir_name):
    os.makedirs(f'./outputs/{dir_name}/', exist_ok=True)
    for i in range(obj.selector.shape[0]):
        preserve(obj, i, file_name=f'outputs/{dir_name}/local-{i}.html')


def ebm_preserve_perf(obj, dir_name):
    os.makedirs(f'./outputs/{dir_name}/', exist_ok=True)
    preserve(obj, file_name=f'outputs/{dir_name}/perf.html')

