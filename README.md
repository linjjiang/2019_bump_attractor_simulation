# Continuous Bump Attractor Network Simulation with Cortical Magnification

A simulation of visual eccentricity effects on working memory precision using continuous bump attractor model.


## Description

Human visual system is retinotopically organized with a cortical magnification: The central visual field is represented with more neurons with a smaller receptive field as compared to peripheral visual field. Such magnified foveal representation significantly impacts our visual processing: for example, our visual acuity decreases with icmreasing visual eccentricity (distance to the central fixation) of the visual stimuli.

However, less is known to what extent such cortical magnification constrains memory processing beyond low-level visual perception.

To address this, this project used bump attractor model to simulate the eccentricity effects on spatial working memory precision, using a continuos bump attractor model (Wimmer et al., 2014). Here, we simulated the effects of eccentricity by varying the size of the bump attractor network based on the previously measured cortical magnification factor from human observers (Duncan & Boynton, 2003). Our simulation matches the human eye-tracking data under the same experimental parameters.

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
Wimmer K, Nykamp DQ, Constantinidis C, Compte A. Bump attractor dynamics in prefrontal cortex explains behavioral precision in spatial working memory. Nat Neurosci. 2014 Mar;17(3):431-9. doi: 10.1038/nn.3645. Epub 2014 Feb 2. PMID: 24487232

