; ModuleID = 'function_struct/main.c'
source_filename = "function_struct/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s = type { i32*, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local { i32*, i32 } @copied(i32* %temp.coerce0, i32 %temp.coerce1) #0 !dbg !7 {
entry:
  %retval = alloca %struct.s, align 8
  %temp = alloca %struct.s, align 8
  %0 = bitcast %struct.s* %temp to { i32*, i32 }*
  %1 = getelementptr inbounds { i32*, i32 }, { i32*, i32 }* %0, i32 0, i32 0
  store i32* %temp.coerce0, i32** %1, align 8
  %2 = getelementptr inbounds { i32*, i32 }, { i32*, i32 }* %0, i32 0, i32 1
  store i32 %temp.coerce1, i32* %2, align 8
  call void @llvm.dbg.declare(metadata %struct.s* %temp, metadata !16, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.declare(metadata %struct.s* %retval, metadata !18, metadata !DIExpression()), !dbg !19
  %val = getelementptr inbounds %struct.s, %struct.s* %temp, i32 0, i32 1, !dbg !20
  %3 = load i32, i32* %val, align 8, !dbg !20
  %val1 = getelementptr inbounds %struct.s, %struct.s* %retval, i32 0, i32 1, !dbg !21
  store i32 %3, i32* %val1, align 8, !dbg !22
  %val2 = getelementptr inbounds %struct.s, %struct.s* %retval, i32 0, i32 1, !dbg !23
  %x = getelementptr inbounds %struct.s, %struct.s* %retval, i32 0, i32 0, !dbg !24
  store i32* %val2, i32** %x, align 8, !dbg !25
  %val3 = getelementptr inbounds %struct.s, %struct.s* %temp, i32 0, i32 1, !dbg !26
  store i32 15, i32* %val3, align 8, !dbg !27
  %val4 = getelementptr inbounds %struct.s, %struct.s* %temp, i32 0, i32 1, !dbg !28
  %4 = load i32, i32* %val4, align 8, !dbg !28
  %cmp = icmp eq i32 %4, 15, !dbg !29
  %conv = zext i1 %cmp to i32, !dbg !29
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !30
  %5 = bitcast %struct.s* %retval to { i32*, i32 }*, !dbg !31
  %6 = load { i32*, i32 }, { i32*, i32 }* %5, align 8, !dbg !31
  ret { i32*, i32 } %6, !dbg !31
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !32 {
entry:
  %retval = alloca i32, align 4
  %object = alloca %struct.s, align 8
  %copy = alloca %struct.s, align 8
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.s* %object, metadata !35, metadata !DIExpression()), !dbg !36
  %val = getelementptr inbounds %struct.s, %struct.s* %object, i32 0, i32 1, !dbg !37
  store i32 10, i32* %val, align 8, !dbg !38
  %val1 = getelementptr inbounds %struct.s, %struct.s* %object, i32 0, i32 1, !dbg !39
  %x = getelementptr inbounds %struct.s, %struct.s* %object, i32 0, i32 0, !dbg !40
  store i32* %val1, i32** %x, align 8, !dbg !41
  call void @llvm.dbg.declare(metadata %struct.s* %copy, metadata !42, metadata !DIExpression()), !dbg !43
  %0 = bitcast %struct.s* %object to { i32*, i32 }*, !dbg !44
  %1 = getelementptr inbounds { i32*, i32 }, { i32*, i32 }* %0, i32 0, i32 0, !dbg !44
  %2 = load i32*, i32** %1, align 8, !dbg !44
  %3 = getelementptr inbounds { i32*, i32 }, { i32*, i32 }* %0, i32 0, i32 1, !dbg !44
  %4 = load i32, i32* %3, align 8, !dbg !44
  %call = call { i32*, i32 } @copied(i32* %2, i32 %4), !dbg !44
  %5 = bitcast %struct.s* %copy to { i32*, i32 }*, !dbg !44
  %6 = getelementptr inbounds { i32*, i32 }, { i32*, i32 }* %5, i32 0, i32 0, !dbg !44
  %7 = extractvalue { i32*, i32 } %call, 0, !dbg !44
  store i32* %7, i32** %6, align 8, !dbg !44
  %8 = getelementptr inbounds { i32*, i32 }, { i32*, i32 }* %5, i32 0, i32 1, !dbg !44
  %9 = extractvalue { i32*, i32 } %call, 1, !dbg !44
  store i32 %9, i32* %8, align 8, !dbg !44
  %val2 = getelementptr inbounds %struct.s, %struct.s* %copy, i32 0, i32 1, !dbg !45
  %10 = load i32, i32* %val2, align 8, !dbg !45
  %cmp = icmp eq i32 %10, 10, !dbg !46
  %conv = zext i1 %cmp to i32, !dbg !46
  %call3 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !47
  %x4 = getelementptr inbounds %struct.s, %struct.s* %object, i32 0, i32 0, !dbg !48
  %11 = load i32*, i32** %x4, align 8, !dbg !48
  %12 = load i32, i32* %11, align 4, !dbg !49
  %cmp5 = icmp eq i32 %12, 10, !dbg !50
  %conv6 = zext i1 %cmp5 to i32, !dbg !50
  %call7 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv6), !dbg !51
  ret i32 0, !dbg !52
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "function_struct/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "copied", scope: !1, file: !1, line: 7, type: !8, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10}
!10 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s", file: !1, line: 1, size: 128, elements: !11)
!11 = !{!12, !15}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !10, file: !1, line: 3, baseType: !13, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "val", scope: !10, file: !1, line: 4, baseType: !14, size: 32, offset: 64)
!16 = !DILocalVariable(name: "temp", arg: 1, scope: !7, file: !1, line: 7, type: !10)
!17 = !DILocation(line: 7, column: 26, scope: !7)
!18 = !DILocalVariable(name: "copy", scope: !7, file: !1, line: 9, type: !10)
!19 = !DILocation(line: 9, column: 11, scope: !7)
!20 = !DILocation(line: 10, column: 18, scope: !7)
!21 = !DILocation(line: 10, column: 7, scope: !7)
!22 = !DILocation(line: 10, column: 11, scope: !7)
!23 = !DILocation(line: 11, column: 17, scope: !7)
!24 = !DILocation(line: 11, column: 7, scope: !7)
!25 = !DILocation(line: 11, column: 9, scope: !7)
!26 = !DILocation(line: 13, column: 7, scope: !7)
!27 = !DILocation(line: 13, column: 11, scope: !7)
!28 = !DILocation(line: 14, column: 14, scope: !7)
!29 = !DILocation(line: 14, column: 18, scope: !7)
!30 = !DILocation(line: 14, column: 2, scope: !7)
!31 = !DILocation(line: 15, column: 2, scope: !7)
!32 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 17, type: !33, scopeLine: 18, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!33 = !DISubroutineType(types: !34)
!34 = !{!14}
!35 = !DILocalVariable(name: "object", scope: !32, file: !1, line: 19, type: !10)
!36 = !DILocation(line: 19, column: 11, scope: !32)
!37 = !DILocation(line: 21, column: 9, scope: !32)
!38 = !DILocation(line: 21, column: 13, scope: !32)
!39 = !DILocation(line: 22, column: 21, scope: !32)
!40 = !DILocation(line: 22, column: 9, scope: !32)
!41 = !DILocation(line: 22, column: 11, scope: !32)
!42 = !DILocalVariable(name: "copy", scope: !32, file: !1, line: 24, type: !10)
!43 = !DILocation(line: 24, column: 11, scope: !32)
!44 = !DILocation(line: 24, column: 18, scope: !32)
!45 = !DILocation(line: 26, column: 14, scope: !32)
!46 = !DILocation(line: 26, column: 17, scope: !32)
!47 = !DILocation(line: 26, column: 2, scope: !32)
!48 = !DILocation(line: 27, column: 18, scope: !32)
!49 = !DILocation(line: 27, column: 9, scope: !32)
!50 = !DILocation(line: 27, column: 20, scope: !32)
!51 = !DILocation(line: 27, column: 2, scope: !32)
!52 = !DILocation(line: 30, column: 4, scope: !32)
