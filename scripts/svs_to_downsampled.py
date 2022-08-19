import openslide

slide = openslide.OpenSlide(snakemake.input[0])

ds_rate = snakemake.wildcards.ds_rate

#this is in the svs images, but easier to write workflow if we can assume them ahead of time..
ds_to_levels={'1x':0,'4x':1,'16x':2,'64x':3}

#level = slide.get_best_level_for_downsample(int(ds_rate))
level = ds_to_levels[ds_rate]


print('dimensions')
print(slide.level_dimensions)
print('downsamples')
print(slide.level_downsamples)


print(f'getting level {level} to downsample by {ds_rate}x')


img = slide.read_region(location=(0,0),level=level,size=slide.level_dimensions[level])

img.save(snakemake.output[0])
