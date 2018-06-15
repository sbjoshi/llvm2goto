; ModuleID = 'bitwise_1_fail/main.c'
source_filename = "bitwise_1_fail/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %res1 = alloca i32, align 4
  %res2 = alloca i32, align 4
  %res3 = alloca i32, align 4
  %res4 = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !10, metadata !12), !dbg !13
  store i32 2, i32* %a, align 4, !dbg !13
  call void @llvm.dbg.declare(metadata i32* %b, metadata !14, metadata !12), !dbg !15
  store i32 3, i32* %b, align 4, !dbg !15
  %0 = load i32, i32* %a, align 4, !dbg !16
  %shr = lshr i32 %0, 2, !dbg !17
  store i32 %shr, i32* %a, align 4, !dbg !18
  call void @llvm.dbg.declare(metadata i32* %res1, metadata !19, metadata !12), !dbg !20
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
  call void @llvm.dbg.declare(metadata i32* %res2, metadata !33, metadata !12), !dbg !34
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
  %cmp11 = icmp eq i32 %12, 8, !dbg !52
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %13 = phi i1 [ false, %entry ], [ %cmp11, %land.rhs ]
  %land.ext = zext i1 %13 to i32, !dbg !53
  %call13 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %land.ext), !dbg !55
  call void @llvm.dbg.declare(metadata i32* %res3, metadata !56, metadata !12), !dbg !57
  %14 = load i32, i32* %a, align 4, !dbg !58
  %15 = load i32, i32* %b, align 4, !dbg !59
  %or = or i32 %14, %15, !dbg !60
  store i32 %or, i32* %res3, align 4, !dbg !57
  %16 = load i32, i32* %res3, align 4, !dbg !61
  %cmp14 = icmp eq i32 %16, 9, !dbg !62
  %conv15 = zext i1 %cmp14 to i32, !dbg !62
  %call16 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv15), !dbg !63
  call void @llvm.dbg.declare(metadata i32* %res4, metadata !64, metadata !12), !dbg !65
  %17 = load i32, i32* %b, align 4, !dbg !66
  %neg = xor i32 %17, -1, !dbg !67
  store i32 %neg, i32* %res4, align 4, !dbg !65
  %18 = load i32, i32* %res4, align 4, !dbg !68
  %cmp17 = icmp eq i32 %18, 1048574, !dbg !69
  %conv18 = zext i1 %cmp17 to i32, !dbg !69
  %call19 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv18), !dbg !70
  ret i32 0, !dbg !71
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
!1 = !DIFile(filename: "bitwise_1_fail/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !7, isLocal: false, isDefinition: true, scopeLine: 2, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "a", scope: !6, file: !1, line: 3, type: !11)
!11 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!12 = !DIExpression()
!13 = !DILocation(line: 3, column: 15, scope: !6)
!14 = !DILocalVariable(name: "b", scope: !6, file: !1, line: 4, type: !11)
!15 = !DILocation(line: 4, column: 15, scope: !6)
!16 = !DILocation(line: 6, column: 6, scope: !6)
!17 = !DILocation(line: 6, column: 7, scope: !6)
!18 = !DILocation(line: 6, column: 4, scope: !6)
!19 = !DILocalVariable(name: "res1", scope: !6, file: !1, line: 7, type: !9)
!20 = !DILocation(line: 7, column: 6, scope: !6)
!21 = !DILocation(line: 7, column: 13, scope: !6)
!22 = !DILocation(line: 7, column: 15, scope: !6)
!23 = !DILocation(line: 7, column: 14, scope: !6)
!24 = !DILocation(line: 8, column: 9, scope: !6)
!25 = !DILocation(line: 8, column: 14, scope: !6)
!26 = !DILocation(line: 8, column: 2, scope: !6)
!27 = !DILocation(line: 10, column: 6, scope: !6)
!28 = !DILocation(line: 10, column: 8, scope: !6)
!29 = !DILocation(line: 10, column: 4, scope: !6)
!30 = !DILocation(line: 11, column: 9, scope: !6)
!31 = !DILocation(line: 11, column: 10, scope: !6)
!32 = !DILocation(line: 11, column: 2, scope: !6)
!33 = !DILocalVariable(name: "res2", scope: !6, file: !1, line: 13, type: !9)
!34 = !DILocation(line: 13, column: 6, scope: !6)
!35 = !DILocation(line: 13, column: 13, scope: !6)
!36 = !DILocation(line: 13, column: 15, scope: !6)
!37 = !DILocation(line: 13, column: 14, scope: !6)
!38 = !DILocation(line: 14, column: 9, scope: !6)
!39 = !DILocation(line: 14, column: 14, scope: !6)
!40 = !DILocation(line: 14, column: 2, scope: !6)
!41 = !DILocation(line: 16, column: 6, scope: !6)
!42 = !DILocation(line: 16, column: 7, scope: !6)
!43 = !DILocation(line: 16, column: 4, scope: !6)
!44 = !DILocation(line: 17, column: 6, scope: !6)
!45 = !DILocation(line: 17, column: 7, scope: !6)
!46 = !DILocation(line: 17, column: 4, scope: !6)
!47 = !DILocation(line: 18, column: 9, scope: !6)
!48 = !DILocation(line: 18, column: 10, scope: !6)
!49 = !DILocation(line: 18, column: 14, scope: !6)
!50 = !DILocation(line: 18, column: 17, scope: !51)
!51 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 2)
!52 = !DILocation(line: 18, column: 18, scope: !51)
!53 = !DILocation(line: 18, column: 14, scope: !54)
!54 = !DILexicalBlockFile(scope: !6, file: !1, discriminator: 4)
!55 = !DILocation(line: 18, column: 2, scope: !54)
!56 = !DILocalVariable(name: "res3", scope: !6, file: !1, line: 20, type: !9)
!57 = !DILocation(line: 20, column: 6, scope: !6)
!58 = !DILocation(line: 20, column: 13, scope: !6)
!59 = !DILocation(line: 20, column: 15, scope: !6)
!60 = !DILocation(line: 20, column: 14, scope: !6)
!61 = !DILocation(line: 21, column: 9, scope: !6)
!62 = !DILocation(line: 21, column: 14, scope: !6)
!63 = !DILocation(line: 21, column: 2, scope: !6)
!64 = !DILocalVariable(name: "res4", scope: !6, file: !1, line: 23, type: !9)
!65 = !DILocation(line: 23, column: 6, scope: !6)
!66 = !DILocation(line: 23, column: 14, scope: !6)
!67 = !DILocation(line: 23, column: 13, scope: !6)
!68 = !DILocation(line: 24, column: 9, scope: !6)
!69 = !DILocation(line: 24, column: 14, scope: !6)
!70 = !DILocation(line: 24, column: 2, scope: !6)
!71 = !DILocation(line: 26, column: 2, scope: !6)
