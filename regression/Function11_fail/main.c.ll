; ModuleID = 'Function11_fail/main.c'
source_filename = "Function11_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.s = type { i32 }

@g = common dso_local global %struct.s zeroinitializer, align 4, !dbg !0

; Function Attrs: noinline nounwind optnone uwtable
define dso_local void @f(i32* %pp) #0 !dbg !16 {
entry:
  %pp.addr = alloca i32*, align 8
  %p3 = alloca i32*, align 8
  store i32* %pp, i32** %pp.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %pp.addr, metadata !20, metadata !DIExpression()), !dbg !21
  call void @llvm.dbg.declare(metadata i32** %p3, metadata !22, metadata !DIExpression()), !dbg !23
  %0 = load i32*, i32** %pp.addr, align 8, !dbg !24
  store i32* %0, i32** %p3, align 8, !dbg !23
  %1 = load i32*, i32** %p3, align 8, !dbg !25
  %cmp = icmp ne i32* %1, getelementptr inbounds (%struct.s, %struct.s* @g, i32 0, i32 0), !dbg !26
  %conv = zext i1 %cmp to i32, !dbg !26
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !27
  ret void, !dbg !28
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !29 {
entry:
  %p1 = alloca i8*, align 8
  %p2 = alloca %struct.s*, align 8
  call void @llvm.dbg.declare(metadata i8** %p1, metadata !32, metadata !DIExpression()), !dbg !34
  store i8* bitcast (%struct.s* @g to i8*), i8** %p1, align 8, !dbg !34
  call void @llvm.dbg.declare(metadata %struct.s** %p2, metadata !35, metadata !DIExpression()), !dbg !36
  %0 = load i8*, i8** %p1, align 8, !dbg !37
  %1 = bitcast i8* %0 to %struct.s*, !dbg !38
  store %struct.s* %1, %struct.s** %p2, align 8, !dbg !36
  %2 = load %struct.s*, %struct.s** %p2, align 8, !dbg !39
  %f = getelementptr inbounds %struct.s, %struct.s* %2, i32 0, i32 0, !dbg !40
  call void @f(i32* %f), !dbg !41
  ret i32 0, !dbg !42
}

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!12, !13, !14}
!llvm.ident = !{!15}

!0 = !DIGlobalVariableExpression(var: !1, expr: !DIExpression())
!1 = distinct !DIGlobalVariable(name: "g", scope: !2, file: !3, line: 3, type: !7, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !11, nameTableKind: None)
!3 = !DIFile(filename: "Function11_fail/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!4 = !{}
!5 = !{!6}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "s", file: !3, line: 1, size: 32, elements: !8)
!8 = !{!9}
!9 = !DIDerivedType(tag: DW_TAG_member, name: "f", scope: !7, file: !3, line: 2, baseType: !10, size: 32)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{!0}
!12 = !{i32 2, !"Dwarf Version", i32 4}
!13 = !{i32 2, !"Debug Info Version", i32 3}
!14 = !{i32 1, !"wchar_size", i32 4}
!15 = !{!"clang version 8.0.0 "}
!16 = distinct !DISubprogram(name: "f", scope: !3, file: !3, line: 5, type: !17, scopeLine: 6, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!17 = !DISubroutineType(types: !18)
!18 = !{null, !19}
!19 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!20 = !DILocalVariable(name: "pp", arg: 1, scope: !16, file: !3, line: 5, type: !19)
!21 = !DILocation(line: 5, column: 13, scope: !16)
!22 = !DILocalVariable(name: "p3", scope: !16, file: !3, line: 7, type: !19)
!23 = !DILocation(line: 7, column: 8, scope: !16)
!24 = !DILocation(line: 7, column: 11, scope: !16)
!25 = !DILocation(line: 8, column: 10, scope: !16)
!26 = !DILocation(line: 8, column: 12, scope: !16)
!27 = !DILocation(line: 8, column: 3, scope: !16)
!28 = !DILocation(line: 9, column: 1, scope: !16)
!29 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 11, type: !30, scopeLine: 12, spFlags: DISPFlagDefinition, unit: !2, retainedNodes: !4)
!30 = !DISubroutineType(types: !31)
!31 = !{!10}
!32 = !DILocalVariable(name: "p1", scope: !29, file: !3, line: 13, type: !33)
!33 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: null, size: 64)
!34 = !DILocation(line: 13, column: 9, scope: !29)
!35 = !DILocalVariable(name: "p2", scope: !29, file: !3, line: 14, type: !6)
!36 = !DILocation(line: 14, column: 13, scope: !29)
!37 = !DILocation(line: 14, column: 28, scope: !29)
!38 = !DILocation(line: 14, column: 16, scope: !29)
!39 = !DILocation(line: 15, column: 7, scope: !29)
!40 = !DILocation(line: 15, column: 11, scope: !29)
!41 = !DILocation(line: 15, column: 3, scope: !29)
!42 = !DILocation(line: 16, column: 1, scope: !29)
