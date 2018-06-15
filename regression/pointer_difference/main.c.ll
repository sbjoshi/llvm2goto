; ModuleID = 'pointer_difference/main.c'
source_filename = "pointer_difference/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %arrayOfInt = alloca [2 x i32], align 4
  %diff1 = alloca i32, align 4
  %diff2 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [2 x i32]* %arrayOfInt, metadata !10, metadata !15), !dbg !16
  call void @llvm.dbg.declare(metadata i32* %diff1, metadata !17, metadata !15), !dbg !18
  %arrayidx = getelementptr inbounds [2 x i32], [2 x i32]* %arrayOfInt, i64 0, i64 1, !dbg !19
  %arraydecay = getelementptr inbounds [2 x i32], [2 x i32]* %arrayOfInt, i32 0, i32 0, !dbg !20
  %sub.ptr.lhs.cast = ptrtoint i32* %arrayidx to i64, !dbg !21
  %sub.ptr.rhs.cast = ptrtoint i32* %arraydecay to i64, !dbg !21
  %sub.ptr.sub = sub i64 %sub.ptr.lhs.cast, %sub.ptr.rhs.cast, !dbg !21
  %sub.ptr.div = sdiv exact i64 %sub.ptr.sub, 4, !dbg !21
  %conv = trunc i64 %sub.ptr.div to i32, !dbg !22
  store i32 %conv, i32* %diff1, align 4, !dbg !18
  %0 = load i32, i32* %diff1, align 4, !dbg !23
  %cmp = icmp eq i32 %0, 1, !dbg !24
  %conv1 = zext i1 %cmp to i32, !dbg !24
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv1), !dbg !25
  call void @llvm.dbg.declare(metadata i32* %diff2, metadata !26, metadata !15), !dbg !27
  %arrayidx2 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayOfInt, i64 0, i64 2, !dbg !28
  %arraydecay3 = getelementptr inbounds [2 x i32], [2 x i32]* %arrayOfInt, i32 0, i32 0, !dbg !29
  %sub.ptr.lhs.cast4 = ptrtoint i32* %arrayidx2 to i64, !dbg !30
  %sub.ptr.rhs.cast5 = ptrtoint i32* %arraydecay3 to i64, !dbg !30
  %sub.ptr.sub6 = sub i64 %sub.ptr.lhs.cast4, %sub.ptr.rhs.cast5, !dbg !30
  %sub.ptr.div7 = sdiv exact i64 %sub.ptr.sub6, 4, !dbg !30
  %conv8 = trunc i64 %sub.ptr.div7 to i32, !dbg !31
  store i32 %conv8, i32* %diff2, align 4, !dbg !27
  %1 = load i32, i32* %diff2, align 4, !dbg !32
  %cmp9 = icmp eq i32 %1, 2, !dbg !33
  %conv10 = zext i1 %cmp9 to i32, !dbg !33
  %call11 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv10), !dbg !34
  ret i32 0, !dbg !35
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "pointer_difference/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !7, isLocal: false, isDefinition: true, scopeLine: 2, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "arrayOfInt", scope: !6, file: !1, line: 3, type: !11)
!11 = !DICompositeType(tag: DW_TAG_array_type, baseType: !12, size: 64, elements: !13)
!12 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!13 = !{!14}
!14 = !DISubrange(count: 2)
!15 = !DIExpression()
!16 = !DILocation(line: 3, column: 16, scope: !6)
!17 = !DILocalVariable(name: "diff1", scope: !6, file: !1, line: 5, type: !9)
!18 = !DILocation(line: 5, column: 7, scope: !6)
!19 = !DILocation(line: 5, column: 16, scope: !6)
!20 = !DILocation(line: 5, column: 32, scope: !6)
!21 = !DILocation(line: 5, column: 30, scope: !6)
!22 = !DILocation(line: 5, column: 15, scope: !6)
!23 = !DILocation(line: 6, column: 10, scope: !6)
!24 = !DILocation(line: 6, column: 15, scope: !6)
!25 = !DILocation(line: 6, column: 3, scope: !6)
!26 = !DILocalVariable(name: "diff2", scope: !6, file: !1, line: 8, type: !12)
!27 = !DILocation(line: 8, column: 16, scope: !6)
!28 = !DILocation(line: 8, column: 25, scope: !6)
!29 = !DILocation(line: 8, column: 42, scope: !6)
!30 = !DILocation(line: 8, column: 40, scope: !6)
!31 = !DILocation(line: 8, column: 24, scope: !6)
!32 = !DILocation(line: 9, column: 10, scope: !6)
!33 = !DILocation(line: 9, column: 15, scope: !6)
!34 = !DILocation(line: 9, column: 3, scope: !6)
!35 = !DILocation(line: 11, column: 3, scope: !6)
