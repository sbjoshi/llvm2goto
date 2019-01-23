; ModuleID = 'for-loop_fail/main.c'
source_filename = "for-loop_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  %z = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %x, metadata !13, metadata !DIExpression()), !dbg !14
  call void @llvm.dbg.declare(metadata i32* %y, metadata !15, metadata !DIExpression()), !dbg !16
  store i32 0, i32* %y, align 4, !dbg !16
  call void @llvm.dbg.declare(metadata i32* %z, metadata !17, metadata !DIExpression()), !dbg !18
  store i32 0, i32* %z, align 4, !dbg !18
  store i32 0, i32* %i, align 4, !dbg !19
  br label %for.cond, !dbg !21

for.cond:                                         ; preds = %for.inc, %entry
  %0 = load i32, i32* %i, align 4, !dbg !22
  %cmp = icmp slt i32 %0, 1000, !dbg !24
  br i1 %cmp, label %for.body, label %for.end, !dbg !25

for.body:                                         ; preds = %for.cond
  %1 = load i32, i32* %x, align 4, !dbg !26
  %tobool = icmp ne i32 %1, 0, !dbg !26
  br i1 %tobool, label %if.then, label %if.else, !dbg !29

if.then:                                          ; preds = %for.body
  %2 = load i32, i32* %y, align 4, !dbg !30
  %inc = add nsw i32 %2, 1, !dbg !30
  store i32 %inc, i32* %y, align 4, !dbg !30
  br label %if.end, !dbg !31

if.else:                                          ; preds = %for.body
  %3 = load i32, i32* %z, align 4, !dbg !32
  %inc1 = add nsw i32 %3, 1, !dbg !32
  store i32 %inc1, i32* %z, align 4, !dbg !32
  br label %if.end

if.end:                                           ; preds = %if.else, %if.then
  br label %for.inc, !dbg !33

for.inc:                                          ; preds = %if.end
  %4 = load i32, i32* %i, align 4, !dbg !34
  %inc2 = add nsw i32 %4, 1, !dbg !34
  store i32 %inc2, i32* %i, align 4, !dbg !34
  br label %for.cond, !dbg !35, !llvm.loop !36

for.end:                                          ; preds = %for.cond
  %5 = load i32, i32* %x, align 4, !dbg !38
  %cmp3 = icmp ne i32 %5, 0, !dbg !39
  br i1 %cmp3, label %land.lhs.true, label %land.end8, !dbg !40

land.lhs.true:                                    ; preds = %for.end
  %6 = load i32, i32* %y, align 4, !dbg !41
  %cmp4 = icmp eq i32 %6, 1000, !dbg !42
  br i1 %cmp4, label %land.rhs, label %land.end8, !dbg !43

land.rhs:                                         ; preds = %land.lhs.true
  %7 = load i32, i32* %x, align 4, !dbg !44
  %cmp5 = icmp eq i32 %7, 0, !dbg !45
  br i1 %cmp5, label %land.rhs6, label %land.end, !dbg !46

land.rhs6:                                        ; preds = %land.rhs
  %8 = load i32, i32* %z, align 4, !dbg !47
  %cmp7 = icmp eq i32 %8, 1000, !dbg !48
  br label %land.end

land.end:                                         ; preds = %land.rhs6, %land.rhs
  %9 = phi i1 [ false, %land.rhs ], [ %cmp7, %land.rhs6 ], !dbg !49
  br label %land.end8

land.end8:                                        ; preds = %land.end, %land.lhs.true, %for.end
  %10 = phi i1 [ false, %land.lhs.true ], [ false, %for.end ], [ %9, %land.end ], !dbg !49
  %land.ext = zext i1 %10 to i32, !dbg !43
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %land.ext), !dbg !50
  %11 = load i32, i32* %retval, align 4, !dbg !51
  ret i32 %11, !dbg !51
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "for-loop_fail/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !8, isLocal: false, isDefinition: true, scopeLine: 4, isOptimized: false, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 5, type: !10)
!12 = !DILocation(line: 5, column: 7, scope: !7)
!13 = !DILocalVariable(name: "x", scope: !7, file: !1, line: 5, type: !10)
!14 = !DILocation(line: 5, column: 9, scope: !7)
!15 = !DILocalVariable(name: "y", scope: !7, file: !1, line: 5, type: !10)
!16 = !DILocation(line: 5, column: 11, scope: !7)
!17 = !DILocalVariable(name: "z", scope: !7, file: !1, line: 5, type: !10)
!18 = !DILocation(line: 5, column: 15, scope: !7)
!19 = !DILocation(line: 6, column: 8, scope: !20)
!20 = distinct !DILexicalBlock(scope: !7, file: !1, line: 6, column: 3)
!21 = !DILocation(line: 6, column: 7, scope: !20)
!22 = !DILocation(line: 6, column: 11, scope: !23)
!23 = distinct !DILexicalBlock(scope: !20, file: !1, line: 6, column: 3)
!24 = !DILocation(line: 6, column: 12, scope: !23)
!25 = !DILocation(line: 6, column: 3, scope: !20)
!26 = !DILocation(line: 8, column: 8, scope: !27)
!27 = distinct !DILexicalBlock(scope: !28, file: !1, line: 8, column: 8)
!28 = distinct !DILexicalBlock(scope: !23, file: !1, line: 7, column: 3)
!29 = !DILocation(line: 8, column: 8, scope: !28)
!30 = !DILocation(line: 9, column: 7, scope: !27)
!31 = !DILocation(line: 9, column: 6, scope: !27)
!32 = !DILocation(line: 11, column: 7, scope: !27)
!33 = !DILocation(line: 12, column: 3, scope: !28)
!34 = !DILocation(line: 6, column: 16, scope: !23)
!35 = !DILocation(line: 6, column: 3, scope: !23)
!36 = distinct !{!36, !25, !37}
!37 = !DILocation(line: 12, column: 3, scope: !20)
!38 = !DILocation(line: 13, column: 11, scope: !7)
!39 = !DILocation(line: 13, column: 12, scope: !7)
!40 = !DILocation(line: 13, column: 16, scope: !7)
!41 = !DILocation(line: 13, column: 19, scope: !7)
!42 = !DILocation(line: 13, column: 20, scope: !7)
!43 = !DILocation(line: 13, column: 26, scope: !7)
!44 = !DILocation(line: 13, column: 30, scope: !7)
!45 = !DILocation(line: 13, column: 31, scope: !7)
!46 = !DILocation(line: 13, column: 35, scope: !7)
!47 = !DILocation(line: 13, column: 38, scope: !7)
!48 = !DILocation(line: 13, column: 39, scope: !7)
!49 = !DILocation(line: 0, scope: !7)
!50 = !DILocation(line: 13, column: 3, scope: !7)
!51 = !DILocation(line: 14, column: 1, scope: !7)
