; ModuleID = 'if6_fail/main.c'
source_filename = "if6_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  %x_prev = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %x_prev, metadata !13, metadata !DIExpression()), !dbg !14
  %0 = load i32, i32* %x, align 4, !dbg !15
  store i32 %0, i32* %x_prev, align 4, !dbg !14
  %1 = load i32, i32* %x, align 4, !dbg !16
  %cmp = icmp sge i32 %1, 0, !dbg !18
  br i1 %cmp, label %if.then, label %if.end12, !dbg !19

if.then:                                          ; preds = %entry
  %2 = load i32, i32* %x, align 4, !dbg !20
  %inc = add nsw i32 %2, 1, !dbg !20
  store i32 %inc, i32* %x, align 4, !dbg !20
  %3 = load i32, i32* %x, align 4, !dbg !22
  %cmp1 = icmp sge i32 %3, 1, !dbg !24
  br i1 %cmp1, label %if.then2, label %if.end11, !dbg !25

if.then2:                                         ; preds = %if.then
  %4 = load i32, i32* %x, align 4, !dbg !26
  %inc3 = add nsw i32 %4, 1, !dbg !26
  store i32 %inc3, i32* %x, align 4, !dbg !26
  %5 = load i32, i32* %x, align 4, !dbg !28
  %cmp4 = icmp sge i32 %5, 2, !dbg !30
  br i1 %cmp4, label %if.then5, label %if.end10, !dbg !31

if.then5:                                         ; preds = %if.then2
  %6 = load i32, i32* %x, align 4, !dbg !32
  %inc6 = add nsw i32 %6, 1, !dbg !32
  store i32 %inc6, i32* %x, align 4, !dbg !32
  %7 = load i32, i32* %x, align 4, !dbg !34
  %cmp7 = icmp sge i32 %7, 3, !dbg !36
  br i1 %cmp7, label %if.then8, label %if.end, !dbg !37

if.then8:                                         ; preds = %if.then5
  %8 = load i32, i32* %x, align 4, !dbg !38
  %inc9 = add nsw i32 %8, 1, !dbg !38
  store i32 %inc9, i32* %x, align 4, !dbg !38
  br label %if.end, !dbg !39

if.end:                                           ; preds = %if.then8, %if.then5
  br label %if.end10, !dbg !40

if.end10:                                         ; preds = %if.end, %if.then2
  br label %if.end11, !dbg !41

if.end11:                                         ; preds = %if.end10, %if.then
  br label %if.end12, !dbg !42

if.end12:                                         ; preds = %if.end11, %entry
  %9 = load i32, i32* %x_prev, align 4, !dbg !43
  %cmp13 = icmp sge i32 %9, 0, !dbg !44
  br i1 %cmp13, label %land.lhs.true, label %lor.rhs, !dbg !45

land.lhs.true:                                    ; preds = %if.end12
  %10 = load i32, i32* %x, align 4, !dbg !46
  %cmp14 = icmp sge i32 %10, 4, !dbg !47
  br i1 %cmp14, label %lor.end, label %lor.rhs, !dbg !48

lor.rhs:                                          ; preds = %land.lhs.true, %if.end12
  %11 = load i32, i32* %x_prev, align 4, !dbg !49
  %cmp15 = icmp slt i32 %11, 0, !dbg !50
  br i1 %cmp15, label %land.rhs, label %land.end, !dbg !51

land.rhs:                                         ; preds = %lor.rhs
  %12 = load i32, i32* %x_prev, align 4, !dbg !52
  %13 = load i32, i32* %x, align 4, !dbg !53
  %cmp16 = icmp eq i32 %12, %13, !dbg !54
  br label %land.end

land.end:                                         ; preds = %land.rhs, %lor.rhs
  %14 = phi i1 [ false, %lor.rhs ], [ %cmp16, %land.rhs ], !dbg !55
  br label %lor.end, !dbg !48

lor.end:                                          ; preds = %land.end, %land.lhs.true
  %15 = phi i1 [ true, %land.lhs.true ], [ %14, %land.end ]
  %lor.ext = zext i1 %15 to i32, !dbg !48
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %lor.ext), !dbg !56
  ret i32 0, !dbg !57
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "min-legal-vector-width"="0" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 8.0.0 ", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2, nameTableKind: None)
!1 = !DIFile(filename: "if6_fail/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !8, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "x", scope: !7, file: !1, line: 3, type: !10)
!12 = !DILocation(line: 3, column: 7, scope: !7)
!13 = !DILocalVariable(name: "x_prev", scope: !7, file: !1, line: 4, type: !10)
!14 = !DILocation(line: 4, column: 7, scope: !7)
!15 = !DILocation(line: 4, column: 16, scope: !7)
!16 = !DILocation(line: 6, column: 6, scope: !17)
!17 = distinct !DILexicalBlock(scope: !7, file: !1, line: 6, column: 6)
!18 = !DILocation(line: 6, column: 7, scope: !17)
!19 = !DILocation(line: 6, column: 6, scope: !7)
!20 = !DILocation(line: 8, column: 6, scope: !21)
!21 = distinct !DILexicalBlock(scope: !17, file: !1, line: 7, column: 3)
!22 = !DILocation(line: 9, column: 8, scope: !23)
!23 = distinct !DILexicalBlock(scope: !21, file: !1, line: 9, column: 8)
!24 = !DILocation(line: 9, column: 9, scope: !23)
!25 = !DILocation(line: 9, column: 8, scope: !21)
!26 = !DILocation(line: 11, column: 8, scope: !27)
!27 = distinct !DILexicalBlock(scope: !23, file: !1, line: 10, column: 5)
!28 = !DILocation(line: 12, column: 10, scope: !29)
!29 = distinct !DILexicalBlock(scope: !27, file: !1, line: 12, column: 10)
!30 = !DILocation(line: 12, column: 11, scope: !29)
!31 = !DILocation(line: 12, column: 10, scope: !27)
!32 = !DILocation(line: 14, column: 10, scope: !33)
!33 = distinct !DILexicalBlock(scope: !29, file: !1, line: 13, column: 7)
!34 = !DILocation(line: 16, column: 12, scope: !35)
!35 = distinct !DILexicalBlock(scope: !33, file: !1, line: 16, column: 12)
!36 = !DILocation(line: 16, column: 13, scope: !35)
!37 = !DILocation(line: 16, column: 12, scope: !33)
!38 = !DILocation(line: 17, column: 12, scope: !35)
!39 = !DILocation(line: 17, column: 11, scope: !35)
!40 = !DILocation(line: 18, column: 7, scope: !33)
!41 = !DILocation(line: 19, column: 5, scope: !27)
!42 = !DILocation(line: 20, column: 3, scope: !21)
!43 = !DILocation(line: 22, column: 12, scope: !7)
!44 = !DILocation(line: 22, column: 18, scope: !7)
!45 = !DILocation(line: 22, column: 22, scope: !7)
!46 = !DILocation(line: 22, column: 25, scope: !7)
!47 = !DILocation(line: 22, column: 26, scope: !7)
!48 = !DILocation(line: 22, column: 30, scope: !7)
!49 = !DILocation(line: 22, column: 34, scope: !7)
!50 = !DILocation(line: 22, column: 40, scope: !7)
!51 = !DILocation(line: 22, column: 43, scope: !7)
!52 = !DILocation(line: 22, column: 46, scope: !7)
!53 = !DILocation(line: 22, column: 54, scope: !7)
!54 = !DILocation(line: 22, column: 52, scope: !7)
!55 = !DILocation(line: 0, scope: !7)
!56 = !DILocation(line: 22, column: 4, scope: !7)
!57 = !DILocation(line: 24, column: 4, scope: !7)
