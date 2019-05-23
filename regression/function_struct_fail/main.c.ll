; ModuleID = 'function_struct_fail/main.c'
source_filename = "function_struct_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s = type { i32*, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local { i32*, i32 } @copied(%struct.s* %temp) #0 !dbg !7 {
entry:
  %retval = alloca %struct.s, align 8
  %temp.addr = alloca %struct.s*, align 8
  store %struct.s* %temp, %struct.s** %temp.addr, align 8
  call void @llvm.dbg.declare(metadata %struct.s** %temp.addr, metadata !17, metadata !DIExpression()), !dbg !18
  call void @llvm.dbg.declare(metadata %struct.s* %retval, metadata !19, metadata !DIExpression()), !dbg !20
  %0 = load %struct.s*, %struct.s** %temp.addr, align 8, !dbg !21
  %val = getelementptr inbounds %struct.s, %struct.s* %0, i32 0, i32 1, !dbg !22
  %1 = load i32, i32* %val, align 8, !dbg !22
  %val1 = getelementptr inbounds %struct.s, %struct.s* %retval, i32 0, i32 1, !dbg !23
  store i32 %1, i32* %val1, align 8, !dbg !24
  %val2 = getelementptr inbounds %struct.s, %struct.s* %retval, i32 0, i32 1, !dbg !25
  %x = getelementptr inbounds %struct.s, %struct.s* %retval, i32 0, i32 0, !dbg !26
  store i32* %val2, i32** %x, align 8, !dbg !27
  %2 = load %struct.s*, %struct.s** %temp.addr, align 8, !dbg !28
  %val3 = getelementptr inbounds %struct.s, %struct.s* %2, i32 0, i32 1, !dbg !29
  store i32 15, i32* %val3, align 8, !dbg !30
  %3 = bitcast %struct.s* %retval to { i32*, i32 }*, !dbg !31
  %4 = load { i32*, i32 }, { i32*, i32 }* %3, align 8, !dbg !31
  ret { i32*, i32 } %4, !dbg !31
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

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
  %call = call { i32*, i32 } @copied(%struct.s* %object), !dbg !44
  %0 = bitcast %struct.s* %copy to { i32*, i32 }*, !dbg !44
  %1 = getelementptr inbounds { i32*, i32 }, { i32*, i32 }* %0, i32 0, i32 0, !dbg !44
  %2 = extractvalue { i32*, i32 } %call, 0, !dbg !44
  store i32* %2, i32** %1, align 8, !dbg !44
  %3 = getelementptr inbounds { i32*, i32 }, { i32*, i32 }* %0, i32 0, i32 1, !dbg !44
  %4 = extractvalue { i32*, i32 } %call, 1, !dbg !44
  store i32 %4, i32* %3, align 8, !dbg !44
  %x2 = getelementptr inbounds %struct.s, %struct.s* %copy, i32 0, i32 0, !dbg !45
  %5 = load i32*, i32** %x2, align 8, !dbg !45
  %6 = load i32, i32* %5, align 4, !dbg !46
  %val3 = getelementptr inbounds %struct.s, %struct.s* %copy, i32 0, i32 1, !dbg !47
  %7 = load i32, i32* %val3, align 8, !dbg !47
  %cmp = icmp eq i32 %6, %7, !dbg !48
  %conv = zext i1 %cmp to i32, !dbg !48
  %call4 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !49
  %val5 = getelementptr inbounds %struct.s, %struct.s* %object, i32 0, i32 1, !dbg !50
  %8 = load i32, i32* %val5, align 8, !dbg !50
  %cmp6 = icmp ne i32 %8, 15, !dbg !51
  %conv7 = zext i1 %cmp6 to i32, !dbg !51
  %call8 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv7), !dbg !52
  ret i32 0, !dbg !53
}

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "function_struct_fail/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "copied", scope: !1, file: !1, line: 7, type: !8, scopeLine: 8, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !16}
!10 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s", file: !1, line: 1, size: 128, elements: !11)
!11 = !{!12, !15}
!12 = !DIDerivedType(tag: DW_TAG_member, name: "x", scope: !10, file: !1, line: 3, baseType: !13, size: 64)
!13 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !14, size: 64)
!14 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "val", scope: !10, file: !1, line: 4, baseType: !14, size: 32, offset: 64)
!16 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!17 = !DILocalVariable(name: "temp", arg: 1, scope: !7, file: !1, line: 7, type: !16)
!18 = !DILocation(line: 7, column: 27, scope: !7)
!19 = !DILocalVariable(name: "copy", scope: !7, file: !1, line: 9, type: !10)
!20 = !DILocation(line: 9, column: 11, scope: !7)
!21 = !DILocation(line: 10, column: 13, scope: !7)
!22 = !DILocation(line: 10, column: 19, scope: !7)
!23 = !DILocation(line: 10, column: 7, scope: !7)
!24 = !DILocation(line: 10, column: 11, scope: !7)
!25 = !DILocation(line: 11, column: 17, scope: !7)
!26 = !DILocation(line: 11, column: 7, scope: !7)
!27 = !DILocation(line: 11, column: 9, scope: !7)
!28 = !DILocation(line: 13, column: 2, scope: !7)
!29 = !DILocation(line: 13, column: 8, scope: !7)
!30 = !DILocation(line: 13, column: 12, scope: !7)
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
!45 = !DILocation(line: 26, column: 16, scope: !32)
!46 = !DILocation(line: 26, column: 9, scope: !32)
!47 = !DILocation(line: 26, column: 27, scope: !32)
!48 = !DILocation(line: 26, column: 19, scope: !32)
!49 = !DILocation(line: 26, column: 2, scope: !32)
!50 = !DILocation(line: 27, column: 16, scope: !32)
!51 = !DILocation(line: 27, column: 20, scope: !32)
!52 = !DILocation(line: 27, column: 2, scope: !32)
!53 = !DILocation(line: 30, column: 4, scope: !32)
