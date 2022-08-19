
subjects=['001'] #placeholder
sessions=['MTL'] #should include L or R here too
ds_rates=['64x']


def get_targets(subjects,sessions,ds_rates):
    
    targets = []

    for subject,session in zip(subjects,sessions):
        samples, = glob_wildcards('raw_data/{subject}/{session}/{{sample}}.svs'.format(subject=subject,session=session))

        targets.extend(
            expand('bids/sub-{subject}/ses-{session}/sub-{subject}_ses-{session}_sample-{sample}_res-{ds_rate}_BF.png',
                    subject=subject,
                    session=session,
                    ds_rate=ds_rates,
                    sample=samples)
               )

    return targets





rule all:
    input: 
        get_targets(subjects,sessions,ds_rates)
        

rule svs_to_downsampled:
    """downsample to get images that are easier to visualize"""
    input:
        'raw_data/{subject}/{session}/{sample}.svs'
    output:
        'bids/sub-{subject}/ses-{session}/sub-{subject}_ses-{session}_sample-{sample}_res-{ds_rate}_BF.png'
    script:
        'scripts/svs_to_downsampled.py'
        


