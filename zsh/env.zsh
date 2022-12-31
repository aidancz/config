export ai=/home/ai
export a=/home/ai/a
for i in $(ls -d $a/*/ | cut -f5 -d'/')
do
	export a_$i=$a/$i
done
export a_gi=/home/ai/a_gi

export http_proxy="http://127.0.0.1:8889/"
export https_proxy=$http_proxy
export all_proxy=$http_proxy
export no_proxy="localhost, 127.0.0.1, ::1"

export VISUAL=nvim
export EDITOR=nvim
export RANGER_LOAD_DEFAULT_RC="false"

export dark_start=18
export dark_end=8
