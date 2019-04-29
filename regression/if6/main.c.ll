; ModuleID = 'if6/main.c'
source_filename = "if6/main.c"
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
  br i1 %cmp, label %land.lhs.true, label %if.end13, !dbg !19

land.lhs.true:                                    ; preds = %entry
  %2 = load i32, i32* %x_prev, align 4, !dbg !20
  %cmp1 = icmp slt i32 %2, 2147483643, !dbg !21
  br i1 %cmp1, label %if.then, label %if.end13, !dbg !22

if.then:                                          ; preds = %land.lhs.true
  %3 = load i32, i32* %x, align 4, !dbg !23
  %inc = add nsw i32 %3, 1, !dbg !23
  store i32 %inc, i32* %x, align 4, !dbg !23
  %4 = load i32, i32* %x, align 4, !dbg !25
  %cmp2 = icmp sge i32 %4, 1, !dbg !27
  br i1 %cmp2, label %if.then3, label %if.end12, !dbg !28

if.then3:                                         ; preds = %if.then
  %5 = load i32, i32* %x, align 4, !dbg !29
  %inc4 = add nsw i32 %5, 1, !dbg !29
  store i32 %inc4, i32* %x, align 4, !dbg !29
  %6 = load i32, i32* %x, align 4, !dbg !31
  %cmp5 = icmp sge i32 %6, 2, !dbg !33
  br i1 %cmp5, label %if.then6, label %if.end11, !dbg !34

if.then6:                                         ; preds = %if.then3
  %7 = load i32, i32* %x, align 4, !dbg !35
  %inc7 = add nsw i32 %7, 1, !dbg !35
  store i32 %inc7, i32* %x, align 4, !dbg !35
  %8 = load i32, i32* %x, align 4, !dbg !37
  %cmp8 = icmp sge i32 %8, 3, !dbg !39
  br i1 %cmp8, label %if.then9, label %if.end, !dbg !40

if.then9:                                         ; preds = %if.then6
  %9 = load i32, i32* %x, align 4, !dbg !41
  %inc10 = add nsw i32 %9, 1, !dbg !41
  store i32 %inc10, i32* %x, align 4, !dbg !41
  br label %if.end, !dbg !42

if.end:                                           ; preds = %if.then9, %if.then6
  br label %if.end11, !dbg !43

if.end11:                                         ; preds = %if.end, %if.then3
  br label %if.end12, !dbg !44

if.end12:                                         ; preds = %if.end11, %if.then
  br label %if.end13, !dbg !45

if.end13:                                         ; preds = %if.end12, %land.lhs.true, %entry
  %10 = load i32, i32* %x_prev, align 4, !dbg !46
  %cmp14 = icmp sge i32 %10, 0, !dbg !47
  br i1 %cmp14, label %land.lhs.true15, label %lor.rhs, !dbg !48

land.lhs.true15:                                  ; preds = %if.end13
  %11 = load i32, i32* %x, align 4, !dbg !49
  %cmp16 = icmp sge i32 %11, 4, !dbg !50
  br i1 %cmp16, label %lor.end, label %lor.rhs, !dbg !51

lor.rhs:                                          ; preds = %land.lhs.true15, %if.end13
  %12 = load i32, i32* %x_prev, align 4, !dbg !52
  %cmp17 = icmp slt i32 %12, 0, !dbg !53
  br i1 %cmp17, label %land.rhs, label %land.end, !dbg !54

land.rhs:                                         ; preds = %lor.rhs
  %13 = load i32, i32* %x_prev, align 4, !dbg !55
  %14 = load i32, i32* %x, align 4, !dbg !56
  %cmp18 = icmp eq i32 %13, %14, !dbg !57
  br label %land.end

land.end:                                         ; preds = %land.rhs, %lor.rhs
  %15 = phi i1 [ false, %lor.rhs ], [ %cmp18, %land.rhs ], !dbg !58
  br label %lor.end, !dbg !51

lor.end:                                          ; preds = %land.end, %land.lhs.true15
  %16 = phi i1 [ true, %land.lhs.true15 ], [ %15, %land.end ]
  %lor.ext = zext i1 %16 to i32, !dbg !51
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %lor.ext), !dbg !59
  ret i32 0, !dbg !60
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
!1 = !DIFile(filename: "if6/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
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
!12 = !DILocation(line: 3, column: 6, scope: !7)
!13 = !DILocalVariable(name: "x_prev", scope: !7, file: !1, line: 4, type: !10)
!14 = !DILocation(line: 4, column: 6, scope: !7)
!15 = !DILocation(line: 4, column: 15, scope: !7)
!16 = !DILocation(line: 6, column: 5, scope: !17)
!17 = distinct !DILexicalBlock(scope: !7, file: !1, line: 6, column: 5)
!18 = !DILocation(line: 6, column: 6, scope: !17)
!19 = !DILocation(line: 6, column: 10, scope: !17)
!20 = !DILocation(line: 6, column: 13, scope: !17)
!21 = !DILocation(line: 6, column: 19, scope: !17)
!22 = !DILocation(line: 6, column: 5, scope: !7)
!23 = !DILocation(line: 8, column: 4, scope: !24)
!24 = distinct !DILexicalBlock(scope: !17, file: !1, line: 7, column: 2)
!25 = !DILocation(line: 9, column: 6, scope: !26)
!26 = distinct !DILexicalBlock(scope: !24, file: !1, line: 9, column: 6)
!27 = !DILocation(line: 9, column: 7, scope: !26)
!28 = !DILocation(line: 9, column: 6, scope: !24)
!29 = !DILocation(line: 11, column: 5, scope: !30)
!30 = distinct !DILexicalBlock(scope: !26, file: !1, line: 10, column: 3)
!31 = !DILocation(line: 12, column: 7, scope: !32)
!32 = distinct !DILexicalBlock(scope: !30, file: !1, line: 12, column: 7)
!33 = !DILocation(line: 12, column: 8, scope: !32)
!34 = !DILocation(line: 12, column: 7, scope: !30)
!35 = !DILocation(line: 14, column: 6, scope: !36)
!36 = distinct !DILexicalBlock(scope: !32, file: !1, line: 13, column: 4)
!37 = !DILocation(line: 16, column: 8, scope: !38)
!38 = distinct !DILexicalBlock(scope: !36, file: !1, line: 16, column: 8)
!39 = !DILocation(line: 16, column: 9, scope: !38)
!40 = !DILocation(line: 16, column: 8, scope: !36)
!41 = !DILocation(line: 17, column: 7, scope: !38)
!42 = !DILocation(line: 17, column: 6, scope: !38)
!43 = !DILocation(line: 18, column: 4, scope: !36)
!44 = !DILocation(line: 19, column: 3, scope: !30)
!45 = !DILocation(line: 20, column: 2, scope: !24)
!46 = !DILocation(line: 22, column: 12, scope: !7)
!47 = !DILocation(line: 22, column: 18, scope: !7)
!48 = !DILocation(line: 22, column: 22, scope: !7)
!49 = !DILocation(line: 22, column: 25, scope: !7)
!50 = !DILocation(line: 22, column: 26, scope: !7)
!51 = !DILocation(line: 22, column: 30, scope: !7)
!52 = !DILocation(line: 22, column: 34, scope: !7)
!53 = !DILocation(line: 22, column: 40, scope: !7)
!54 = !DILocation(line: 22, column: 43, scope: !7)
!55 = !DILocation(line: 22, column: 46, scope: !7)
!56 = !DILocation(line: 22, column: 54, scope: !7)
!57 = !DILocation(line: 22, column: 52, scope: !7)
!58 = !DILocation(line: 0, scope: !7)
!59 = !DILocation(line: 22, column: 4, scope: !7)
!60 = !DILocation(line: 24, column: 4, scope: !7)
