# Low-latency localization by Active LED Markers tracking using a Dynamic Vision Sensor


This repository contains the source code 
for a Python implementation of the method
contained in the paper 

<div class='pub_ref_page'>
    <p class='pub-ref-short'><span class="author">A.C., Jonas Strubel, <a href='http://sensors.ini.uzh.ch/christian.html'>Christian Brandli</a>, <a href='http://www.ini.uzh.ch/~tobi'>Tobi Delbruck</a>, and <a href='https://sites.google.com/site/scarabotix/home'>Davide Scaramuzza</a>.</span>
    <span class="title" style='font-weight:bold'><strong>Low-latency localization by Active LED Markers tracking using a Dynamic Vision Sensor</strong>.</span>
    <span class="booktitle">In <em>IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS)</em>, 891&ndash;898. Tokyo,Japan, November 2013.</span>
    <span class="links"><span class="pdf"><a href="http://purl.org/censi/research/2013-dvs-sub.pdf"><img style='border:0; height: 17px; margin-bottom:-6px'   width='16' src='http://censi.mit.edu/media/pdf.gif'/> pdf</a></span> <span class="slides"><a href="http://purl.org/censi/research/2013-dvs-slides.pdf"><img style='border:0; margin-bottom:-6px; height: 17px;'  src='http://censi.mit.edu/media/slides2.gif' width='16' /> slides</a></span></span>

    <!--<a class='pub-ref-bibtex-link' onclick='javascript:$("#censi13dvs").toggle();' href='javascript:void(0)'>bibtex</a><pre class='pub-ref-bibtex' id='censi13dvs' style='display: none;'>@inproceedings{censi13dvs,
        author = "Censi, Andrea and Strubel, Jonas and Brandli, Christian and Delbruck, Tobi and Scaramuzza, Davide",
        doi = "10.1109/IROS.2013.6696456",
        title = "Low-latency localization by Active LED Markers tracking using a Dynamic Vision Sensor",
        url = "http://purl.org/censi/2013/dvs",
        booktitle = "IEEE/RSJ International Conference on Intelligent Robots and Systems (IROS)",
        year = "2013",
        month = "November",
        slides = "http://purl.org/censi/research/2013-dvs-slides.pdf",
        pages = "891--898",
        address = "Tokyo,Japan",
        pdf = "http://purl.org/censi/research/2013-dvs-sub.pdf",
        abstract = "At the current state of the art, the agility of an autonomous flying robot is limited by the speed of its sensing pipeline, as the relatively high latency and low sampling frequency limit the aggressiveness of the control strategies that can be implemented. To obtain more agile robots, we need faster sensors. A Dynamic Vision Sensor (DVS) encodes changes in the perceived brightness using an address-event representation. The latency of such sensors can be measured in the microseconds, thus offering the theoretical possibility of creating a sensing pipeline whose latency is negligible compared to the dynamics of the platform. However, to use these sensors we must rethink the way we interpret visual data. We present an approach to low-latency pose tracking using a DVS and Active Led Markers (ALMs), which are LEDs blinking at high frequency (>1 KHz). The DVS time resolution is able to distinguish different frequencies, thus avoiding the need for data association. We compare the DVS approach to traditional tracking using a CMOS camera, and we show that the DVS performance is not affected by fast motion, unlike the CMOS camera, which suffers from motion blur."
    }</pre></p>
    <div class='previews'><div class='pdf-preview paper'><a href='http://purl.org/censi/research/2013-dvs-sub.pdf'><img src='http://censi.mit.edu/media/pdf_preview/censi13dvs.png'/><br/>paper</a></div><div class='pdf-preview slides'><a href='http://purl.org/censi/research/2013-dvs-slides.pdf'><img src='http://censi.mit.edu/media/pdf_preview/censi13dvs-slides.png'/><br/>slides</a></div></div><div class='after-previews'></div>-->
</div>



The paper's PDF, slides, and other additional materials are found [on this webpage][webpage].

[webpage]: http://purl.org/censi/2013/dvs

## Step 1: Setting up the development environment

The Python source code for the method is contained in the [``rcl`` repository](https://github.com/AndreaCensi/env_dvs). Note, however, that there are a bunch of dependences  across a bunch of repositories
(on the ``env_dvs`` branch). 

[See here for instructions on how to setup the development environment](README-development.md).

##  Step 2: Downloading example dataset

The next step is downloading the example dataset from

  <http://censi.mit.edu/pub/1212-DVS-data/>

For example, you can use the command

    $ wget -m -L http://censi.mit.edu/pub/1212-DVS-data/

##  Step 3: Running the code

At this point you should have completed the two steps above, which means:

1) You have downloaded the directory ``1212-DVS-data``
2) You have an ``environment.sh`` file created during the setup.

Now, setup the environment using:

    $ source environment.sh

And make sure that the executables are correctly installed. For example:

    # check "aer_video" exists
    $ which aer_video 
    <your path>/deploy/bin/aer_video


### Creating videos of the event data

Use this to create a video of a .aedat file with slices = 0.03 seconds:

    aer_video  --log 1212-DVS-data/data/dec10/flying/l11.aedat -o tmp-videos --interval 0.03  -c make

You can create videos using different intervals for the slice by giving more 
arguments to ``--interval``. Note the [Compmake][compmake] ``parmake`` argument to
``-c`` which makes the computation run in parallel (if you have multiple processors).

    aer_video  --log 1212-DVS-data/data/dec10/flying/l2.aedat -o videos2 --interval 0.03 0.01 0.001 -c parmake


[compmake]: http://andreacensi.github.io/compmake/

    

### Other simple stats about the data

There are a bunch of commands that display some simple statistics
of the data. These are most useful as simple code examples to read through.

The command ``aer_stats_events`` displays some simple spatial statistics:

    $ aer_stats_events -o events2 --log data/nov23/detail_2.aedat -c "clean;make"

<!--The command ``aer_simple_stats` displays ...

$ aer_simple_stats -o simple2 --log data/dec10/flying/l2.aedat -->

The command ``aer_stats_freq` displays the transition frequencies detected in a log.

    $ aer_stats_freq -o freq1 --log data/dec10/flying/l2.aedat 

The following is the output, which shows the dominant frequencies 
corresponding to the different LEDs.

<img src="aer_stats_freq.png"/>


### Running the detection algorithm

The configuration is a bit clunky. You should have on the current directory the
``aer_blink_conf.yaml`` file found in the ``rcl`` repository. This file 
contains the frequencies to use for each log. 

This runs the detector on the file ``data/dec6/l1.aedat``

    $ aer_blink_detect -o l2 -c make --suffix i02p3d15 --log data/dec6/l2.aedat --interval 0.002 --npeaks 3 --min_led_distance 15

The method parameters are:

- ``interval``: Interval to use (s). This is the latency of the method.
- ``npeaks``: Number of peaks to detect.
- ``min_led_distance``: Minimum distance between different LEDs (pixels).

The other parameters have to do with the computation and visualization:

- ``--log <log1> ... <log n>``: logs to work on
- ``-o <dir>``: indicates the output directory
- ``-suffix <string>``: gives a string that indicates this configuration
- ``-c <compmake commands>``: A [Compmake][compmake] command (try: ``make`` or ``parmake``)

    








