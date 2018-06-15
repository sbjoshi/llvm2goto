; ModuleID = 'function_struct/main.c'
source_filename = "function_struct/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s = type { i32*, i32 }

; Function Attrs: noinline nounwind uwtable
define { i32*, i32 } @copied(i32* %temp.coerce0, i32 %temp.coerce1) #0 !dbg !6 {
entry:
  %retval = alloca %struct.s, align 8
  %temp = alloca %struct.s, align 8
  %copy = alloca %struct.s, align 8
  %0 = bitcast %struct.s* %temp to { i32*, i32 }*
  %1 = getelementptr inbounds { i32*, i32 }, { i32*, i32 }* %0, i32 0, i32 0
  store i32* %temp.coerce0, i32** %1, align 8
  %2 = getelementptr inbounds { i32*, i32 }, { i32*, i32 }* %0, i32 0, i32 1
  store i32 %temp.coerce1, i32* %2, align 8
  call void @llvm.dbg.declare(metadata %struct.s* %temp, metadata !15, metadata !16), !dbg !17
  call void @llvm.dbg.declare(metadata %struct.s* %copy, metadata !18, metadata !16), !dbg !19
  %val = getelementptr inbounds %struct.s, %struct.s* %temp, i32 0, i32 1, !dbg !20
  %3 = load i32, i32* %val, align 8, !dbg !20
  %val1 = getelementptr inbounds %struct.s, %struct.s* %copy, i32 0, i32 1, !dbg !21
  store i32 %3, i32* %val1, align 8, !dbg !22
  %val2 = getelementptr inbounds %struct.s, %struct.s* %copy, i32 0, i32 1, !dbg !23
  %x = getelementptr inbounds %struct.s, %struct.s* %copy, i32 0, i32 0, !dbg !24
  store i32* %val2, i32** %x, align 8, !dbg !25
  %val3 = getelementptr inbounds %struct.s, %struct.s* %temp, i32 0, i32 1, !dbg !26
  store i32 15, i32* %val3, align 8, !dbg !27
  %val4 = getelementptr inbounds %struct.s, %struct.s* %temp, i32 0, i32 1, !dbg !28
  %4 = load i32, i32* %val4, align 8, !dbg !28
  %cmp = icmp eq i32 %4, 15, !dbg !29
  %conv = zext i1 %cmp to i32, !dbg !29
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !30
  %5 = bitcast %struct.s* %retval to i8*, !dbg !31
  %6 = bitcast %struct.s* %copy to i8*, !dbg !31
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %5, i8* %6, i64 16, i32 8, i1 false), !dbg !31
  %7 = bitcast %struct.s* %retval to { i32*, i32 }*, !dbg !32
  %8 = load { i32*, i32 }, { i32*, i32 }* %7, align 8, !dbg !32
  ret { i32*, i32 } %8, !dbg !32
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #3

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !33 {
entry:
  %retval = alloca i32, align 4
  %object = alloca %struct.s, align 8
  %copy = alloca %struct.s, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s* %object, metadata !36, metadata !16), !dbg !37
  %val = getelementptr inbounds %struct.s, %struct.s* %object, i32 0, i32 1, !dbg !38
  store i32 10, i32* %val, align 8, !dbg !39
  %val1 = getelementptr inbounds %struct.s, %struct.s* %object, i32 0, i32 1, !dbg !40
  %x = getelementptr inbounds %struct.s, %struct.s* %object, i32 0, i32 0, !dbg !41
  store i32* %val1, i32** %x, align 8, !dbg !42
  call void @llvm.dbg.declare(metadata %struct.s* %copy, metadata !43, metadata !16), !dbg !44
  %0 = bitcast %struct.s* %object to { i32*, i32 }*, !dbg !45
  %1 = getelementptr inbounds { i32*, i32 }, { i32*, i32 }* %0, i32 0, i32 0, !dbg !45
  %2 = load i32*, i32** %1, align 8, !dbg !45
  %3 = getelementptr inbounds { i32*, i32 }, { i32*, i32 }* %0, i32 0, i32 1, !dbg !45
  %4 = load i32, i32* %3, align 8, !dbg !45
  %call = call { i32*, i32 } @copied(i32* %2, i32 %4), !dbg !45
  %5 = bitcast %struct.s* %copy to { i32*, i32 }*, !dbg !45
  %6 = getelementptr inbounds { i32*, i32 }, { i32*, i32 }* %5, i32 0, i32 0, !dbg !45
  %7 = extractvalue { i32*, i32 } %call, 0, !dbg !45
  store i32* %7, i32** %6, align 8, !dbg !45
  %8 = getelementptr inbounds { i32*, i32 }, { i32*, i32 }* %5, i32 0, i32 1, !dbg !45
  %9 = extractvalue { i32*, i32 } %call, 1, !dbg !45
  store i32 %9, i32* %8, align 8, !dbg !45
  %val2 = getelementptr inbounds %struct.s, %struct.s* %copy, i32 0, i32 1, !dbg !46
  %10 = load i32, i32* %val2, align 8, !dbg !46
  %cmp = icmp eq i32 %10, 10, !dbg !47
  %conv = zext i1 %cmp to i32, !dbg !47
  %call3 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !48
  %x4 = getelementptr inbounds %struct.s, %struct.s* %object, i32 0, i32 0, !dbg !49
  %11 = load i32*, i32** %x4, align 8, !dbg !49
  %12 = load i32, i32* %11, align 4, !dbg !50
  %cmp5 = icmp eq i32 %12, 10, !dbg !51
  %conv6 = zext i1 %cmp5 to i32, !dbg !51
  %call7 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv6), !dbg !52
  ret i32 0, !dbg !53
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #3 = { argmemonly nounwind }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "function_struct/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "copied", scope: !1, file: !1, line: 7, type: !7, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9, !9}
!9 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s", file: !1, line: 1, size: 128, elements: !10)
!10 = !{!11, !14}
!11 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !9, file: !1, line: 3, baseType: !12, size: 64)
!12 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !13, size: 64)
!13 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!14 = !DIDerivedType(tag: DW_TAG_member, name: "val", scope: !9, file: !1, line: 4, baseType: !13, size: 32, offset: 64)
!15 = !DILocalVariable(name: "temp", arg: 1, scope: !6, file: !1, line: 7, type: !9)
!16 = !DIExpression()
!17 = !DILocation(line: 7, column: 26, scope: !6)
!18 = !DILocalVariable(name: "copy", scope: !6, file: !1, line: 9, type: !9)
!19 = !DILocation(line: 9, column: 11, scope: !6)
!20 = !DILocation(line: 10, column: 18, scope: !6)
!21 = !DILocation(line: 10, column: 7, scope: !6)
!22 = !DILocation(line: 10, column: 11, scope: !6)
!23 = !DILocation(line: 11, column: 17, scope: !6)
!24 = !DILocation(line: 11, column: 7, scope: !6)
!25 = !DILocation(line: 11, column: 9, scope: !6)
!26 = !DILocation(line: 13, column: 7, scope: !6)
!27 = !DILocation(line: 13, column: 11, scope: !6)
!28 = !DILocation(line: 14, column: 14, scope: !6)
!29 = !DILocation(line: 14, column: 18, scope: !6)
!30 = !DILocation(line: 14, column: 2, scope: !6)
!31 = !DILocation(line: 15, column: 9, scope: !6)
!32 = !DILocation(line: 15, column: 2, scope: !6)
!33 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 17, type: !34, isLocal: false, isDefinition: true, scopeLine: 18, isOptimized: false, unit: !0, variables: !2)
!34 = !DISubroutineType(types: !35)
!35 = !{!13}
!36 = !DILocalVariable(name: "object", scope: !33, file: !1, line: 19, type: !9)
!37 = !DILocation(line: 19, column: 11, scope: !33)
!38 = !DILocation(line: 21, column: 9, scope: !33)
!39 = !DILocation(line: 21, column: 13, scope: !33)
!40 = !DILocation(line: 22, column: 21, scope: !33)
!41 = !DILocation(line: 22, column: 9, scope: !33)
!42 = !DILocation(line: 22, column: 11, scope: !33)
!43 = !DILocalVariable(name: "copy", scope: !33, file: !1, line: 24, type: !9)
!44 = !DILocation(line: 24, column: 11, scope: !33)
!45 = !DILocation(line: 24, column: 18, scope: !33)
!46 = !DILocation(line: 26, column: 14, scope: !33)
!47 = !DILocation(line: 26, column: 17, scope: !33)
!48 = !DILocation(line: 26, column: 2, scope: !33)
!49 = !DILocation(line: 27, column: 18, scope: !33)
!50 = !DILocation(line: 27, column: 9, scope: !33)
!51 = !DILocation(line: 27, column: 20, scope: !33)
!52 = !DILocation(line: 27, column: 2, scope: !33)
!53 = !DILocation(line: 30, column: 4, scope: !33)
