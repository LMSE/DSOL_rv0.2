# for running DSOL1

conf_file=parameters.json
parameter_setting_id="DeepSol1"
keras_backend=theano
cuda_root='/usr/local/cuda'
device=cpu

. parse_options.sh || exit 1;


if [ $# != 1 ]; then
    echo "usage: ./run.sh <data-dir>"
    echo "e.g.:  ./run.sh data/protein_dsol1.data"
    echo "main options (for others, see top of script file)"
    echo "  --conf_file                                        # default full."
    echo "  --parameter_setting_id                             # default full."
    echo "  --keras_backend                                    # use graphs in src-dir"
    echo "  --cuda_root                                        # number of parallel jobs"
    echo "  --device                                           # config containing options"
    exit 1;
fi

data=$1

if [[ "$device" == 'cpu' ]] ; then
    export THEANO_FLAGS="base_compiledir=$(pwd)/.theano,device=${device},floatX=float32"
fi

if [[ $device == *"cuda"* ]]; then
    export CUDA_HOME=${cuda_root}
    export LD_LIBRARY_PATH=${cuda_root}/lib64
    export THEANO_FLAGS="base_compiledir=$(pwd)/.theano,cuda.root=${cuda_root},device=${device},floatX=float32"
fi


export KERAS_BACKEND=${keras_backend} 

./main_dsol1.py -conf_file ${conf_file} -parameter_setting_id ${parameter_setting_id} -data ${data}

# for running DSOL2
#python main_dsol2.py -data data/protein_dsol2.data -conf_file parameters.json -parameter_setting_id DeepSol2

# for running DSOL3 
#python main_dsol3.py -data data/protein_dsol2.data -conf_file parameters.json -parameter_setting_id DeepSol3