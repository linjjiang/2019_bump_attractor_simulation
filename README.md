# Continuous Bump Attractor Network Simulation with Cortical Magnification

A simulation of visual eccentricity effects on working memory precision using continuous bump attractor model.


## Description

The human visual system is retinotopically organized and exhibits cortical magnification: the central visual field is represented by a greater number of neurons with smaller receptive fields compared to the peripheral visual field. This foveal magnification plays a critical role in visual processing—most notably, visual acuity declines as stimulus eccentricity (distance from the center of gaze) increases.

While the role of cortical magnification in low-level visual perception is well established, its constraints on memory processing remain less understood.

This project explores how cortical magnification may constrain spatial working memory precision. We employ a continuous bump attractor model (Wimmer et al., 2014) to simulate the effects of stimulus eccentricity on memory performance. The model incorporates variations in network size based on empirical estimates of the human cortical magnification factor (Duncan & Boynton, 2003). Simulation results closely align with human eye-tracking data collected under matching experimental conditions.

This simulation was reported in the following paper:
Jiang, L., & Leung, H. C. (2021). Errors in visuospatial working memory across space and time. Scientific Reports, 11(1). https://doi.org/10.1038/s41598-021-93858-6


## Getting Started

### Dependencies

* MATLAB R2019b or later

### Installing

* Download this repo and add it to your MATLAB path

### Executing program

* In MATLAB, run the bump_attractor_main.m script to generate simulations and plot results.
```
run bump_attractor_main.m
```

## Help

## Authors

Linjing Jiang
[@linjjiang](https://github.com/linjjiang)

## Version History

* 0.1
    * Initial Release

## License

This project is licensed under the MIT License - see the LICENSE.md file for details

## Acknowledgments

This simulation is based on the code provided by the following paper:
* Wimmer K, Nykamp DQ, Constantinidis C, Compte A. Bump attractor dynamics in prefrontal cortex explains behavioral precision in spatial working memory. Nat Neurosci. 2014 Mar;17(3):431-9. doi: 10.1038/nn.3645. Epub 2014 Feb 2. PMID: 24487232

