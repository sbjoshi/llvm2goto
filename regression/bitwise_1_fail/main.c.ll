; ModuleID = 'bitwise_1_fail/main.c'
source_filename = "bitwise_1_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %res1 = alloca i32, align 4
  %res2 = alloca i32, align 4
  %res3 = alloca i32, align 4
  %res4 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !11, metadata !DIExpression()), !dbg !13
  store i32 2, i32* %a, align 4, !dbg !13
  call void @llvm.dbg.declare(metadata i32* %b, metadata !14, metadata !DIExpression()), !dbg !15
  store i32 3, i32* %b, align 4, !dbg !15
  %0 = load i32, i32* %a, align 4, !dbg !16
  %shr = lshr i32 %0, 2, !dbg !17
  store i32 %shr, i32* %a, align 4, !dbg !18
  call void @llvm.dbg.declare(metadata i32* %res1, metadata !19, metadata !DIExpression()), !dbg !20
  %1 = load i32, i32* %a, align 4, !dbg !21
  %2 = load i32, i32* %b, align 4, !dbg !22
  %and = and i32 %1, %2, !dbg !23
  store i32 %and, i32* %res1, align 4, !dbg !20
  %3 = load i32, i32* %res1, align 4, !dbg !24
  %cmp = icmp eq i32 %3, 2, !dbg !25
  %conv = zext i1 %cmp to i32, !dbg !25
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !26
  %4 = load i32, i32* %a, align 4, !dbg !27
  %shl = shl i32 %4, 1, !dbg !28
  store i32 %shl, i32* %a, align 4, !dbg !29
  %5 = load i32, i32* %a, align 4, !dbg !30
  %cmp1 = icmp eq i32 %5, 4, !dbg !31
  %conv2 = zext i1 %cmp1 to i32, !dbg !31
  %call3 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv2), !dbg !32
  call void @llvm.dbg.declare(metadata i32* %res2, metadata !33, metadata !DIExpression()), !dbg !34
  %6 = load i32, i32* %a, align 4, !dbg !35
  %7 = load i32, i32* %b, align 4, !dbg !36
  %xor = xor i32 %6, %7, !dbg !37
  store i32 %xor, i32* %res2, align 4, !dbg !34
  %8 = load i32, i32* %res2, align 4, !dbg !38
  %cmp4 = icmp eq i32 %8, 7, !dbg !39
  %conv5 = zext i1 %cmp4 to i32, !dbg !39
  %call6 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv5), !dbg !40
  %9 = load i32, i32* %b, align 4, !dbg !41
  %shr7 = lshr i32 %9, 1, !dbg !42
  store i32 %shr7, i32* %b, align 4, !dbg !43
  %10 = load i32, i32* %a, align 4, !dbg !44
  %shl8 = shl i32 %10, 1, !dbg !45
  store i32 %shl8, i32* %a, align 4, !dbg !46
  %11 = load i32, i32* %b, align 4, !dbg !47
  %cmp9 = icmp eq i32 %11, 1, !dbg !48
  br i1 %cmp9, label %land.rhs, label %land.end, !dbg !49

land.rhs:                                         ; preds = %entry
  %12 = load i32, i32* %a, align 4, !dbg !50
  %cmp11 = icmp eq i32 %12, 8, !dbg !51
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %13 = phi i1 [ false, %entry ], [ %cmp11, %land.rhs ], !dbg !52
  %land.ext = zext i1 %13 to i32, !dbg !49
  %call13 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %land.ext), !dbg !53
  call void @llvm.dbg.declare(metadata i32* %res3, metadata !54, metadata !DIExpression()), !dbg !55
  %14 = load i32, i32* %a, align 4, !dbg !56
  %15 = load i32, i32* %b, align 4, !dbg !57
  %or = or i32 %14, %15, !dbg !58
  store i32 %or, i32* %res3, align 4, !dbg !55
  %16 = load i32, i32* %res3, align 4, !dbg !59
  %cmp14 = icmp eq i32 %16, 9, !dbg !60
  %conv15 = zext i1 %cmp14 to i32, !dbg !60
  %call16 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv15), !dbg !61
  call void @llvm.dbg.declare(metadata i32* %res4, metadata !62, metadata !DIExpression()), !dbg !63
  %17 = load i32, i32* %b, align 4, !dbg !64
  %neg = xor i32 %17, -1, !dbg !65
  store i32 %neg, i32* %res4, align 4, !dbg !63
  %18 = load i32, i32* %res4, align 4, !dbg !66
  %cmp17 = icmp eq i32 %18, 1048574, !dbg !67
  %conv18 = zext i1 %cmp17 to i32, !dbg !67
  %call19 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv18), !dbg !68
  ret i32 0, !dbg !69
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
!1 = !DIFile(filename: "bitwise_1_fail/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !8, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 3, type: !12)
!12 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!13 = !DILocation(line: 3, column: 15, scope: !7)
!14 = !DILocalVariable(name: "b", scope: !7, file: !1, line: 4, type: !12)
!15 = !DILocation(line: 4, column: 15, scope: !7)
!16 = !DILocation(line: 6, column: 6, scope: !7)
!17 = !DILocation(line: 6, column: 7, scope: !7)
!18 = !DILocation(line: 6, column: 4, scope: !7)
!19 = !DILocalVariable(name: "res1", scope: !7, file: !1, line: 7, type: !10)
!20 = !DILocation(line: 7, column: 6, scope: !7)
!21 = !DILocation(line: 7, column: 13, scope: !7)
!22 = !DILocation(line: 7, column: 15, scope: !7)
!23 = !DILocation(line: 7, column: 14, scope: !7)
!24 = !DILocation(line: 8, column: 9, scope: !7)
!25 = !DILocation(line: 8, column: 14, scope: !7)
!26 = !DILocation(line: 8, column: 2, scope: !7)
!27 = !DILocation(line: 10, column: 6, scope: !7)
!28 = !DILocation(line: 10, column: 8, scope: !7)
!29 = !DILocation(line: 10, column: 4, scope: !7)
!30 = !DILocation(line: 11, column: 9, scope: !7)
!31 = !DILocation(line: 11, column: 10, scope: !7)
!32 = !DILocation(line: 11, column: 2, scope: !7)
!33 = !DILocalVariable(name: "res2", scope: !7, file: !1, line: 13, type: !10)
!34 = !DILocation(line: 13, column: 6, scope: !7)
!35 = !DILocation(line: 13, column: 13, scope: !7)
!36 = !DILocation(line: 13, column: 15, scope: !7)
!37 = !DILocation(line: 13, column: 14, scope: !7)
!38 = !DILocation(line: 14, column: 9, scope: !7)
!39 = !DILocation(line: 14, column: 14, scope: !7)
!40 = !DILocation(line: 14, column: 2, scope: !7)
!41 = !DILocation(line: 16, column: 6, scope: !7)
!42 = !DILocation(line: 16, column: 7, scope: !7)
!43 = !DILocation(line: 16, column: 4, scope: !7)
!44 = !DILocation(line: 17, column: 6, scope: !7)
!45 = !DILocation(line: 17, column: 7, scope: !7)
!46 = !DILocation(line: 17, column: 4, scope: !7)
!47 = !DILocation(line: 18, column: 9, scope: !7)
!48 = !DILocation(line: 18, column: 10, scope: !7)
!49 = !DILocation(line: 18, column: 14, scope: !7)
!50 = !DILocation(line: 18, column: 17, scope: !7)
!51 = !DILocation(line: 18, column: 18, scope: !7)
!52 = !DILocation(line: 0, scope: !7)
!53 = !DILocation(line: 18, column: 2, scope: !7)
!54 = !DILocalVariable(name: "res3", scope: !7, file: !1, line: 20, type: !10)
!55 = !DILocation(line: 20, column: 6, scope: !7)
!56 = !DILocation(line: 20, column: 13, scope: !7)
!57 = !DILocation(line: 20, column: 15, scope: !7)
!58 = !DILocation(line: 20, column: 14, scope: !7)
!59 = !DILocation(line: 21, column: 9, scope: !7)
!60 = !DILocation(line: 21, column: 14, scope: !7)
!61 = !DILocation(line: 21, column: 2, scope: !7)
!62 = !DILocalVariable(name: "res4", scope: !7, file: !1, line: 23, type: !10)
!63 = !DILocation(line: 23, column: 6, scope: !7)
!64 = !DILocation(line: 23, column: 14, scope: !7)
!65 = !DILocation(line: 23, column: 13, scope: !7)
!66 = !DILocation(line: 24, column: 9, scope: !7)
!67 = !DILocation(line: 24, column: 14, scope: !7)
!68 = !DILocation(line: 24, column: 2, scope: !7)
!69 = !DILocation(line: 26, column: 2, scope: !7)
