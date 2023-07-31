/// @description
uniTime = shader_get_uniform(sh_water,"Time");
uniOffset = shader_get_uniform(sh_water,"Offset");
uniTexel = shader_get_uniform(sh_water,"Texel");
uniMask = shader_get_sampler_index(sh_water,"Mask");

refl_surf = -1;
refl_mask_surf = -1;