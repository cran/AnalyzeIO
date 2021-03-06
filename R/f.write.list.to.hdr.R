
f.write.list.to.hdr<-function(L,file){

# Writes a list to a .hdr file
a<-.C("write_analyze_header",
      file,
      as.integer(L$size.of.header),
      as.character(L$data.type),
      as.character(L$db.name),
      as.integer(L$extents),
      as.integer(L$session.error),
      as.character(L$regular),
      as.character(L$hkey.un0),
      as.integer(L$dim),
      as.character(L$vox.units),
      as.character(L$cal.units),
      as.integer(L$unused1),
      as.integer(L$datatype),
      as.integer(L$bitpix),
      as.integer(L$dim.un0),
      as.single(L$pixdim),
      as.single(L$vox.offset),
      as.single(L$funused1),
      as.single(L$funused2),
      as.single(L$funused3),
      as.single(L$cal.max),
      as.single(L$cal.min),
      as.single(L$compressed),
      as.single(L$verified),
      as.integer(L$glmax),
      as.integer(L$glmin),
      as.character(L$descrip),
      as.character(L$aux.file),
      as.character(L$orient),
      as.character(L$originator),
      as.character(L$generated),
      as.character(L$scannum),
      as.character(L$patient.id),
      as.character(L$exp.date),
      as.character(L$exp.time),
      as.character(L$hist.un0),
      as.integer(L$views),
      as.integer(L$vols.added),
      as.integer(L$start.field),
      as.integer(L$field.skip),
      as.integer(L$omax),
      as.integer(L$omin),
      as.integer(L$smax),
      as.integer(L$smin))
}

