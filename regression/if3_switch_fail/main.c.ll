; ModuleID = 'if3_switch_fail/main.c'
source_filename = "if3_switch_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !11, metadata !DIExpression()), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %j, metadata !13, metadata !DIExpression()), !dbg !14
  %0 = load i32, i32* %i, align 4, !dbg !15
  %cmp = icmp sgt i32 %0, 0, !dbg !17
  br i1 %cmp, label %if.then, label %if.else9, !dbg !18

if.then:                                          ; preds = %entry
  %1 = load i32, i32* %j, align 4, !dbg !19
  %cmp1 = icmp sgt i32 %1, 0, !dbg !22
  br i1 %cmp1, label %if.then2, label %if.else, !dbg !23

if.then2:                                         ; preds = %if.then
  %2 = load i32, i32* %j, align 4, !dbg !24
  %add = add nsw i32 %2, 1, !dbg !26
  store i32 %add, i32* %j, align 4, !dbg !27
  br label %if.end7, !dbg !28

if.else:                                          ; preds = %if.then
  %3 = load i32, i32* %j, align 4, !dbg !29
  %cmp3 = icmp eq i32 %3, 0, !dbg !31
  br i1 %cmp3, label %if.then4, label %if.else6, !dbg !32

if.then4:                                         ; preds = %if.else
  %4 = load i32, i32* %j, align 4, !dbg !33
  %add5 = add nsw i32 %4, 1, !dbg !35
  store i32 %add5, i32* %j, align 4, !dbg !36
  br label %if.end, !dbg !37

if.else6:                                         ; preds = %if.else
  store i32 0, i32* %j, align 4, !dbg !38
  br label %if.end

if.end:                                           ; preds = %if.else6, %if.then4
  br label %if.end7

if.end7:                                          ; preds = %if.end, %if.then2
  %5 = load i32, i32* %j, align 4, !dbg !40
  %cmp8 = icmp sge i32 %5, 0, !dbg !41
  %conv = zext i1 %cmp8 to i32, !dbg !41
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !42
  br label %if.end14, !dbg !43

if.else9:                                         ; preds = %entry
  %6 = load i32, i32* %j, align 4, !dbg !44
  switch i32 %6, label %sw.default [
    i32 0, label %sw.bb
    i32 -1, label %sw.bb10
  ], !dbg !46

sw.bb:                                            ; preds = %if.else9
  store i32 -1, i32* %j, align 4, !dbg !47
  br label %sw.epilog, !dbg !49

sw.bb10:                                          ; preds = %if.else9
  store i32 -2, i32* %j, align 4, !dbg !50
  br label %sw.epilog, !dbg !51

sw.default:                                       ; preds = %if.else9
  %7 = load i32, i32* %j, align 4, !dbg !52
  store i32 %7, i32* %j, align 4, !dbg !53
  br label %sw.epilog, !dbg !54

sw.epilog:                                        ; preds = %sw.default, %sw.bb10, %sw.bb
  %8 = load i32, i32* %j, align 4, !dbg !55
  %cmp11 = icmp slt i32 %8, 0, !dbg !56
  %conv12 = zext i1 %cmp11 to i32, !dbg !56
  %call13 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv12), !dbg !57
  br label %if.end14

if.end14:                                         ; preds = %sw.epilog, %if.end7
  %9 = load i32, i32* %i, align 4, !dbg !58
  %cmp15 = icmp sgt i32 %9, 0, !dbg !59
  br i1 %cmp15, label %lor.lhs.false, label %land.rhs, !dbg !60

lor.lhs.false:                                    ; preds = %if.end14
  %10 = load i32, i32* %j, align 4, !dbg !61
  %cmp17 = icmp sge i32 %10, 0, !dbg !62
  br i1 %cmp17, label %land.rhs, label %land.end, !dbg !63

land.rhs:                                         ; preds = %lor.lhs.false, %if.end14
  %11 = load i32, i32* %i, align 4, !dbg !64
  %cmp19 = icmp sle i32 %11, 0, !dbg !65
  br i1 %cmp19, label %lor.rhs, label %lor.end, !dbg !66

lor.rhs:                                          ; preds = %land.rhs
  %12 = load i32, i32* %j, align 4, !dbg !67
  %cmp21 = icmp slt i32 %12, 0, !dbg !68
  br label %lor.end, !dbg !66

lor.end:                                          ; preds = %lor.rhs, %land.rhs
  %13 = phi i1 [ true, %land.rhs ], [ %cmp21, %lor.rhs ]
  br label %land.end

land.end:                                         ; preds = %lor.end, %lor.lhs.false
  %14 = phi i1 [ false, %lor.lhs.false ], [ %13, %lor.end ], !dbg !69
  %land.ext = zext i1 %14 to i32, !dbg !63
  %call23 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %land.ext), !dbg !70
  %15 = load i32, i32* %retval, align 4, !dbg !71
  ret i32 %15, !dbg !71
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
!1 = !DIFile(filename: "if3_switch_fail/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 3, type: !8, scopeLine: 4, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 5, type: !10)
!12 = !DILocation(line: 5, column: 6, scope: !7)
!13 = !DILocalVariable(name: "j", scope: !7, file: !1, line: 5, type: !10)
!14 = !DILocation(line: 5, column: 8, scope: !7)
!15 = !DILocation(line: 7, column: 5, scope: !16)
!16 = distinct !DILexicalBlock(scope: !7, file: !1, line: 7, column: 5)
!17 = !DILocation(line: 7, column: 6, scope: !16)
!18 = !DILocation(line: 7, column: 5, scope: !7)
!19 = !DILocation(line: 9, column: 6, scope: !20)
!20 = distinct !DILexicalBlock(scope: !21, file: !1, line: 9, column: 6)
!21 = distinct !DILexicalBlock(scope: !16, file: !1, line: 8, column: 2)
!22 = !DILocation(line: 9, column: 7, scope: !20)
!23 = !DILocation(line: 9, column: 6, scope: !21)
!24 = !DILocation(line: 11, column: 7, scope: !25)
!25 = distinct !DILexicalBlock(scope: !20, file: !1, line: 10, column: 3)
!26 = !DILocation(line: 11, column: 8, scope: !25)
!27 = !DILocation(line: 11, column: 5, scope: !25)
!28 = !DILocation(line: 12, column: 3, scope: !25)
!29 = !DILocation(line: 13, column: 11, scope: !30)
!30 = distinct !DILexicalBlock(scope: !20, file: !1, line: 13, column: 11)
!31 = !DILocation(line: 13, column: 12, scope: !30)
!32 = !DILocation(line: 13, column: 11, scope: !20)
!33 = !DILocation(line: 15, column: 8, scope: !34)
!34 = distinct !DILexicalBlock(scope: !30, file: !1, line: 14, column: 3)
!35 = !DILocation(line: 15, column: 9, scope: !34)
!36 = !DILocation(line: 15, column: 6, scope: !34)
!37 = !DILocation(line: 16, column: 3, scope: !34)
!38 = !DILocation(line: 19, column: 6, scope: !39)
!39 = distinct !DILexicalBlock(scope: !30, file: !1, line: 18, column: 3)
!40 = !DILocation(line: 22, column: 10, scope: !21)
!41 = !DILocation(line: 22, column: 11, scope: !21)
!42 = !DILocation(line: 22, column: 3, scope: !21)
!43 = !DILocation(line: 23, column: 2, scope: !21)
!44 = !DILocation(line: 26, column: 10, scope: !45)
!45 = distinct !DILexicalBlock(scope: !16, file: !1, line: 25, column: 2)
!46 = !DILocation(line: 26, column: 3, scope: !45)
!47 = !DILocation(line: 28, column: 15, scope: !48)
!48 = distinct !DILexicalBlock(scope: !45, file: !1, line: 27, column: 3)
!49 = !DILocation(line: 28, column: 21, scope: !48)
!50 = !DILocation(line: 29, column: 16, scope: !48)
!51 = !DILocation(line: 29, column: 23, scope: !48)
!52 = !DILocation(line: 30, column: 18, scope: !48)
!53 = !DILocation(line: 30, column: 16, scope: !48)
!54 = !DILocation(line: 30, column: 22, scope: !48)
!55 = !DILocation(line: 33, column: 10, scope: !45)
!56 = !DILocation(line: 33, column: 11, scope: !45)
!57 = !DILocation(line: 33, column: 3, scope: !45)
!58 = !DILocation(line: 37, column: 12, scope: !7)
!59 = !DILocation(line: 37, column: 13, scope: !7)
!60 = !DILocation(line: 37, column: 17, scope: !7)
!61 = !DILocation(line: 37, column: 21, scope: !7)
!62 = !DILocation(line: 37, column: 22, scope: !7)
!63 = !DILocation(line: 37, column: 28, scope: !7)
!64 = !DILocation(line: 37, column: 34, scope: !7)
!65 = !DILocation(line: 37, column: 35, scope: !7)
!66 = !DILocation(line: 37, column: 40, scope: !7)
!67 = !DILocation(line: 37, column: 45, scope: !7)
!68 = !DILocation(line: 37, column: 46, scope: !7)
!69 = !DILocation(line: 0, scope: !7)
!70 = !DILocation(line: 37, column: 2, scope: !7)
!71 = !DILocation(line: 38, column: 1, scope: !7)
