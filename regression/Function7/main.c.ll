; ModuleID = 'Function7/main.c'
source_filename = "Function7/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define void @fun(i32* %x) #0 !dbg !6 {
entry:
  %x.addr = alloca i32*, align 8
  store i32* %x, i32** %x.addr, align 8
  call void @llvm.dbg.declare(metadata i32** %x.addr, metadata !11, metadata !12), !dbg !13
  ret void, !dbg !14
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !15 {
entry:
  %var = alloca [8 x i32], align 16
  %p = alloca i32*, align 8
  call void @llvm.dbg.declare(metadata [8 x i32]* %var, metadata !19, metadata !12), !dbg !24
  call void @llvm.dbg.declare(metadata i32** %p, metadata !25, metadata !12), !dbg !26
  %arraydecay = getelementptr inbounds [8 x i32], [8 x i32]* %var, i32 0, i32 0, !dbg !27
  store i32* %arraydecay, i32** %p, align 8, !dbg !26
  %0 = load i32*, i32** %p, align 8, !dbg !28
  call void @fun(i32* %0), !dbg !29
  ret i32 0, !dbg !30
}

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "Function7/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "fun", scope: !1, file: !1, line: 3, type: !7, isLocal: false, isDefinition: true, scopeLine: 4, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{null, !9}
!9 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!10 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!11 = !DILocalVariable(name: "x", arg: 1, scope: !6, file: !1, line: 3, type: !9)
!12 = !DIExpression()
!13 = !DILocation(line: 3, column: 12, scope: !6)
!14 = !DILocation(line: 5, column: 1, scope: !6)
!15 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 7, type: !16, isLocal: false, isDefinition: true, scopeLine: 8, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!16 = !DISubroutineType(types: !17)
!17 = !{!18}
!18 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!19 = !DILocalVariable(name: "var", scope: !15, file: !1, line: 9, type: !20)
!20 = !DIDerivedType(tag: DW_TAG_typedef, name: "B", file: !1, line: 1, baseType: !21)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 256, elements: !22)
!22 = !{!23}
!23 = !DISubrange(count: 8)
!24 = !DILocation(line: 9, column: 5, scope: !15)
!25 = !DILocalVariable(name: "p", scope: !15, file: !1, line: 10, type: !9)
!26 = !DILocation(line: 10, column: 13, scope: !15)
!27 = !DILocation(line: 10, column: 17, scope: !15)
!28 = !DILocation(line: 11, column: 7, scope: !15)
!29 = !DILocation(line: 11, column: 3, scope: !15)
!30 = !DILocation(line: 12, column: 1, scope: !15)