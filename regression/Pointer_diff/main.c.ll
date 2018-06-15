; ModuleID = 'Pointer_diff/main.c'
source_filename = "Pointer_diff/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

@array = common global [100 x i32] zeroinitializer, align 16, !dbg !0

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !16 {
entry:
  %p = alloca i32*, align 8
  %diff = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32** %p, metadata !19, metadata !21), !dbg !22
  store i32* getelementptr inbounds ([100 x i32], [100 x i32]* @array, i32 0, i32 0), i32** %p, align 8, !dbg !22
  call void @llvm.dbg.declare(metadata i32* %diff, metadata !23, metadata !21), !dbg !24
  %0 = load i32*, i32** %p, align 8, !dbg !25
  %add.ptr = getelementptr inbounds i32, i32* %0, i64 30, !dbg !25
  store i32* %add.ptr, i32** %p, align 8, !dbg !25
  %1 = load i32*, i32** %p, align 8, !dbg !26
  %2 = bitcast i32* %1 to i8*, !dbg !27
  %sub.ptr.lhs.cast = ptrtoint i8* %2 to i64, !dbg !28
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, ptrtoint ([100 x i32]* @array to i64), !dbg !28
  %conv = trunc i64 %sub.ptr.sub to i32, !dbg !27
  store i32 %conv, i32* %diff, align 4, !dbg !29
  %3 = load i32, i32* %diff, align 4, !dbg !30
  %conv1 = sext i32 %3 to i64, !dbg !30
  %cmp = icmp eq i64 %conv1, 120, !dbg !31
  %conv2 = zext i1 %cmp to i32, !dbg !31
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv2), !dbg !32
  ret i32 0, !dbg !33
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!2}
!llvm.module.flags = !{!13, !14}
!llvm.ident = !{!15}

!0 = !DIGlobalVariableExpression(var: !1)
!1 = distinct !DIGlobalVariable(name: "array", scope: !2, file: !3, line: 1, type: !9, isLocal: false, isDefinition: true)
!2 = distinct !DICompileUnit(language: DW_LANG_C99, file: !3, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !4, retainedTypes: !5, globals: !8)
!3 = !DIFile(filename: "Pointer_diff/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!4 = !{}
!5 = !{!6}
!6 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !7, size: 64)
!7 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!8 = !{!0}
!9 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 3200, elements: !11)
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !{!12}
!12 = !DISubrange(count: 100)
!13 = !{i32 2, !"Dwarf Version", i32 4}
!14 = !{i32 2, !"Debug Info Version", i32 3}
!15 = !{!"clang version 5.0.0 (trunk 295264)"}
!16 = distinct !DISubprogram(name: "main", scope: !3, file: !3, line: 3, type: !17, isLocal: false, isDefinition: true, scopeLine: 4, isOptimized: false, unit: !2, variables: !4)
!17 = !DISubroutineType(types: !18)
!18 = !{!10}
!19 = !DILocalVariable(name: "p", scope: !16, file: !3, line: 5, type: !20)
!20 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !10, size: 64)
!21 = !DIExpression()
!22 = !DILocation(line: 5, column: 8, scope: !16)
!23 = !DILocalVariable(name: "diff", scope: !16, file: !3, line: 6, type: !10)
!24 = !DILocation(line: 6, column: 7, scope: !16)
!25 = !DILocation(line: 8, column: 4, scope: !16)
!26 = !DILocation(line: 9, column: 16, scope: !16)
!27 = !DILocation(line: 9, column: 8, scope: !16)
!28 = !DILocation(line: 9, column: 17, scope: !16)
!29 = !DILocation(line: 9, column: 7, scope: !16)
!30 = !DILocation(line: 11, column: 10, scope: !16)
!31 = !DILocation(line: 11, column: 14, scope: !16)
!32 = !DILocation(line: 11, column: 3, scope: !16)
!33 = !DILocation(line: 12, column: 1, scope: !16)
