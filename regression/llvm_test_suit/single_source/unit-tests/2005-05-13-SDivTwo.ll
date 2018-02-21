; ModuleID = '2005-05-13-SDivTwo.c'
source_filename = "2005-05-13-SDivTwo.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !9 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !13, metadata !14), !dbg !15
  store i32 0, i32* %i, align 4, !dbg !16
  br label %for.cond, !dbg !18

for.cond:                                         ; preds = %for.body, %entry
  %0 = load i32, i32* %i, align 4, !dbg !19
  %cmp = icmp ne i32 %0, 258, !dbg !21
  br i1 %cmp, label %for.body, label %for.end, !dbg !22

for.body:                                         ; preds = %for.cond
  call void @llvm.dbg.declare(metadata i32* %j, metadata !23, metadata !14), !dbg !25
  %1 = load i32, i32* %i, align 4, !dbg !26
  %conv = trunc i32 %1 to i8, !dbg !27
  %conv1 = sext i8 %conv to i32, !dbg !28
  %div = sdiv i32 %conv1, 2, !dbg !29
  store i32 %div, i32* %j, align 4, !dbg !25
  %2 = load i32, i32* %i, align 4, !dbg !30
  %inc = add nsw i32 %2, 1, !dbg !30
  store i32 %inc, i32* %i, align 4, !dbg !30
  %3 = load i32, i32* %j, align 4, !dbg !31
  %4 = load i32, i32* %i, align 4, !dbg !32
  %conv2 = trunc i32 %4 to i8, !dbg !33
  %conv3 = sext i8 %conv2 to i32, !dbg !34
  %div4 = sdiv i32 %conv3, 2, !dbg !35
  %cmp5 = icmp eq i32 %3, %div4, !dbg !36
  %conv6 = zext i1 %cmp5 to i32, !dbg !36
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv6), !dbg !37
  %5 = load i32, i32* %i, align 4, !dbg !38
  %inc7 = add nsw i32 %5, 1, !dbg !38
  store i32 %inc7, i32* %i, align 4, !dbg !38
  br label %for.cond, !dbg !39, !llvm.loop !40

for.end:                                          ; preds = %for.cond
  ret i32 0, !dbg !42
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!5, !6, !7}
!llvm.ident = !{!8}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, retainedTypes: !3)
!1 = !DIFile(filename: "2005-05-13-SDivTwo.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{!4}
!4 = !DIBasicType(name: "signed char", size: 8, encoding: DW_ATE_signed_char)
!5 = !{i32 2, !"Dwarf Version", i32 4}
!6 = !{i32 2, !"Debug Info Version", i32 3}
!7 = !{i32 1, !"wchar_size", i32 4}
!8 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!9 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !10, isLocal: false, isDefinition: true, scopeLine: 3, isOptimized: false, unit: !0, variables: !2)
!10 = !DISubroutineType(types: !11)
!11 = !{!12}
!12 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!13 = !DILocalVariable(name: "i", scope: !9, file: !1, line: 4, type: !12)
!14 = !DIExpression()
!15 = !DILocation(line: 4, column: 7, scope: !9)
!16 = !DILocation(line: 5, column: 10, scope: !17)
!17 = distinct !DILexicalBlock(scope: !9, file: !1, line: 5, column: 3)
!18 = !DILocation(line: 5, column: 8, scope: !17)
!19 = !DILocation(line: 5, column: 15, scope: !20)
!20 = distinct !DILexicalBlock(scope: !17, file: !1, line: 5, column: 3)
!21 = !DILocation(line: 5, column: 17, scope: !20)
!22 = !DILocation(line: 5, column: 3, scope: !17)
!23 = !DILocalVariable(name: "j", scope: !24, file: !1, line: 6, type: !12)
!24 = distinct !DILexicalBlock(scope: !20, file: !1, line: 5, column: 26)
!25 = !DILocation(line: 6, column: 8, scope: !24)
!26 = !DILocation(line: 6, column: 26, scope: !24)
!27 = !DILocation(line: 6, column: 13, scope: !24)
!28 = !DILocation(line: 6, column: 12, scope: !24)
!29 = !DILocation(line: 6, column: 29, scope: !24)
!30 = !DILocation(line: 7, column: 5, scope: !24)
!31 = !DILocation(line: 8, column: 11, scope: !24)
!32 = !DILocation(line: 8, column: 30, scope: !24)
!33 = !DILocation(line: 8, column: 17, scope: !24)
!34 = !DILocation(line: 8, column: 16, scope: !24)
!35 = !DILocation(line: 8, column: 33, scope: !24)
!36 = !DILocation(line: 8, column: 13, scope: !24)
!37 = !DILocation(line: 8, column: 4, scope: !24)
!38 = !DILocation(line: 9, column: 5, scope: !24)
!39 = !DILocation(line: 5, column: 3, scope: !20)
!40 = distinct !{!40, !22, !41}
!41 = !DILocation(line: 11, column: 3, scope: !17)
!42 = !DILocation(line: 12, column: 3, scope: !9)
