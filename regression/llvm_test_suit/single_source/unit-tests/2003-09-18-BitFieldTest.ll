; ModuleID = '2003-09-18-BitFieldTest.c'
source_filename = "2003-09-18-BitFieldTest.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.rtx_def = type { i8, [3 x i8] }

; Function Attrs: noinline nounwind optnone uwtable
define void @i2(%struct.rtx_def* %d) #0 !dbg !7 {
entry:
  %d.addr = alloca %struct.rtx_def*, align 8
  store %struct.rtx_def* %d, %struct.rtx_def** %d.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.rtx_def** %d.addr, metadata !16, metadata !17), !dbg !18
  %0 = load %struct.rtx_def*, %struct.rtx_def** %d.addr, align 8, !dbg !19
  %1 = bitcast %struct.rtx_def* %0 to i8*, !dbg !20
  %bf.load = load i8, i8* %1, align 4, !dbg !21
  %bf.clear = and i8 %bf.load, -2, !dbg !21
  store i8 %bf.clear, i8* %1, align 4, !dbg !21
  ret void, !dbg !22
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !23 {
entry:
  %retval = alloca i32, align 4
  %D = alloca %struct.rtx_def, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.rtx_def* %D, metadata !27, metadata !17), !dbg !28
  %0 = bitcast %struct.rtx_def* %D to i8*, !dbg !29
  %bf.load = load i8, i8* %0, align 4, !dbg !30
  %bf.clear = and i8 %bf.load, -3, !dbg !30
  %bf.set = or i8 %bf.clear, 2, !dbg !30
  store i8 %bf.set, i8* %0, align 4, !dbg !30
  call void @i2(%struct.rtx_def* %D), !dbg !31
  %1 = bitcast %struct.rtx_def* %D to i8*, !dbg !32
  %bf.load1 = load i8, i8* %1, align 4, !dbg !32
  %bf.clear2 = and i8 %bf.load1, 1, !dbg !32
  %bf.cast = zext i8 %bf.clear2 to i32, !dbg !32
  %cmp = icmp eq i32 %bf.cast, 0, !dbg !33
  %conv = zext i1 %cmp to i32, !dbg !33
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !34
  %2 = bitcast %struct.rtx_def* %D to i8*, !dbg !35
  %bf.load3 = load i8, i8* %2, align 4, !dbg !35
  %bf.lshr = lshr i8 %bf.load3, 1, !dbg !35
  %bf.clear4 = and i8 %bf.lshr, 1, !dbg !35
  %bf.cast5 = zext i8 %bf.clear4 to i32, !dbg !35
  %cmp6 = icmp eq i32 %bf.cast5, 1, !dbg !36
  %conv7 = zext i1 %cmp6 to i32, !dbg !36
  %call8 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv7), !dbg !37
  ret i32 0, !dbg !38
}

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "2003-09-18-BitFieldTest.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "i2", scope: !1, file: !1, line: 8, type: !8, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{null, !10}
!10 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !11, size: 64)
!11 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "rtx_def", file: !1, line: 3, size: 32, elements: !12)
!12 = !{!13, !15}
!13 = !DIDerivedType(tag: DW_TAG_member, name: "jump", scope: !11, file: !1, line: 4, baseType: !14, size: 1, flags: DIFlagBitField, extraData: i64 0)
!14 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "call", scope: !11, file: !1, line: 5, baseType: !14, size: 1, offset: 1, flags: DIFlagBitField, extraData: i64 0)
!16 = !DILocalVariable(name: "d", arg: 1, scope: !7, file: !1, line: 8, type: !10)
!17 = !DIExpression()
!18 = !DILocation(line: 8, column: 25, scope: !7)
!19 = !DILocation(line: 9, column: 3, scope: !7)
!20 = !DILocation(line: 9, column: 6, scope: !7)
!21 = !DILocation(line: 9, column: 11, scope: !7)
!22 = !DILocation(line: 10, column: 1, scope: !7)
!23 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !24, isLocal: false, isDefinition: true, scopeLine: 12, isOptimized: false, unit: !0, variables: !2)
!24 = !DISubroutineType(types: !25)
!25 = !{!26}
!26 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!27 = !DILocalVariable(name: "D", scope: !23, file: !1, line: 13, type: !11)
!28 = !DILocation(line: 13, column: 18, scope: !23)
!29 = !DILocation(line: 14, column: 5, scope: !23)
!30 = !DILocation(line: 14, column: 10, scope: !23)
!31 = !DILocation(line: 15, column: 3, scope: !23)
!32 = !DILocation(line: 17, column: 12, scope: !23)
!33 = !DILocation(line: 17, column: 17, scope: !23)
!34 = !DILocation(line: 17, column: 3, scope: !23)
!35 = !DILocation(line: 18, column: 12, scope: !23)
!36 = !DILocation(line: 18, column: 17, scope: !23)
!37 = !DILocation(line: 18, column: 3, scope: !23)
!38 = !DILocation(line: 19, column: 3, scope: !23)
