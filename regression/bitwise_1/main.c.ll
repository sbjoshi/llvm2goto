; ModuleID = 'bitwise_1/main.c'
source_filename = "bitwise_1/main.c"
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
  call void @llvm.dbg.declare(metadata i32* %res1, metadata !16, metadata !DIExpression()), !dbg !17
  %0 = load i32, i32* %a, align 4, !dbg !18
  %1 = load i32, i32* %b, align 4, !dbg !19
  %and = and i32 %0, %1, !dbg !20
  store i32 %and, i32* %res1, align 4, !dbg !17
  %2 = load i32, i32* %res1, align 4, !dbg !21
  %cmp = icmp eq i32 %2, 2, !dbg !22
  %conv = zext i1 %cmp to i32, !dbg !22
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !23
  %3 = load i32, i32* %a, align 4, !dbg !24
  %shl = shl i32 %3, 1, !dbg !25
  store i32 %shl, i32* %a, align 4, !dbg !26
  %4 = load i32, i32* %a, align 4, !dbg !27
  %cmp1 = icmp eq i32 %4, 4, !dbg !28
  %conv2 = zext i1 %cmp1 to i32, !dbg !28
  %call3 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv2), !dbg !29
  call void @llvm.dbg.declare(metadata i32* %res2, metadata !30, metadata !DIExpression()), !dbg !31
  %5 = load i32, i32* %a, align 4, !dbg !32
  %6 = load i32, i32* %b, align 4, !dbg !33
  %xor = xor i32 %5, %6, !dbg !34
  store i32 %xor, i32* %res2, align 4, !dbg !31
  %7 = load i32, i32* %res2, align 4, !dbg !35
  %cmp4 = icmp eq i32 %7, 7, !dbg !36
  %conv5 = zext i1 %cmp4 to i32, !dbg !36
  %call6 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv5), !dbg !37
  %8 = load i32, i32* %b, align 4, !dbg !38
  %shr = lshr i32 %8, 1, !dbg !39
  store i32 %shr, i32* %b, align 4, !dbg !40
  %9 = load i32, i32* %a, align 4, !dbg !41
  %shl7 = shl i32 %9, 1, !dbg !42
  store i32 %shl7, i32* %a, align 4, !dbg !43
  %10 = load i32, i32* %b, align 4, !dbg !44
  %cmp8 = icmp eq i32 %10, 1, !dbg !45
  br i1 %cmp8, label %land.rhs, label %land.end, !dbg !46

land.rhs:                                         ; preds = %entry
  %11 = load i32, i32* %a, align 4, !dbg !47
  %cmp10 = icmp eq i32 %11, 8, !dbg !48
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %12 = phi i1 [ false, %entry ], [ %cmp10, %land.rhs ], !dbg !49
  %land.ext = zext i1 %12 to i32, !dbg !46
  %call12 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %land.ext), !dbg !50
  call void @llvm.dbg.declare(metadata i32* %res3, metadata !51, metadata !DIExpression()), !dbg !52
  %13 = load i32, i32* %a, align 4, !dbg !53
  %14 = load i32, i32* %b, align 4, !dbg !54
  %or = or i32 %13, %14, !dbg !55
  store i32 %or, i32* %res3, align 4, !dbg !52
  %15 = load i32, i32* %res3, align 4, !dbg !56
  %cmp13 = icmp eq i32 %15, 9, !dbg !57
  %conv14 = zext i1 %cmp13 to i32, !dbg !57
  %call15 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv14), !dbg !58
  call void @llvm.dbg.declare(metadata i32* %res4, metadata !59, metadata !DIExpression()), !dbg !60
  %16 = load i32, i32* %b, align 4, !dbg !61
  %neg = xor i32 %16, -1, !dbg !62
  store i32 %neg, i32* %res4, align 4, !dbg !60
  %17 = load i32, i32* %res4, align 4, !dbg !63
  %cmp16 = icmp eq i32 %17, -2, !dbg !64
  %conv17 = zext i1 %cmp16 to i32, !dbg !64
  %call18 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv17), !dbg !65
  ret i32 0, !dbg !66
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
!1 = !DIFile(filename: "bitwise_1/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !8, isLocal: false, isDefinition: true, scopeLine: 2, isOptimized: false, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 3, type: !12)
!12 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!13 = !DILocation(line: 3, column: 15, scope: !7)
!14 = !DILocalVariable(name: "b", scope: !7, file: !1, line: 4, type: !12)
!15 = !DILocation(line: 4, column: 15, scope: !7)
!16 = !DILocalVariable(name: "res1", scope: !7, file: !1, line: 6, type: !10)
!17 = !DILocation(line: 6, column: 6, scope: !7)
!18 = !DILocation(line: 6, column: 13, scope: !7)
!19 = !DILocation(line: 6, column: 15, scope: !7)
!20 = !DILocation(line: 6, column: 14, scope: !7)
!21 = !DILocation(line: 7, column: 9, scope: !7)
!22 = !DILocation(line: 7, column: 14, scope: !7)
!23 = !DILocation(line: 7, column: 2, scope: !7)
!24 = !DILocation(line: 9, column: 6, scope: !7)
!25 = !DILocation(line: 9, column: 8, scope: !7)
!26 = !DILocation(line: 9, column: 4, scope: !7)
!27 = !DILocation(line: 10, column: 9, scope: !7)
!28 = !DILocation(line: 10, column: 10, scope: !7)
!29 = !DILocation(line: 10, column: 2, scope: !7)
!30 = !DILocalVariable(name: "res2", scope: !7, file: !1, line: 12, type: !10)
!31 = !DILocation(line: 12, column: 6, scope: !7)
!32 = !DILocation(line: 12, column: 13, scope: !7)
!33 = !DILocation(line: 12, column: 15, scope: !7)
!34 = !DILocation(line: 12, column: 14, scope: !7)
!35 = !DILocation(line: 13, column: 9, scope: !7)
!36 = !DILocation(line: 13, column: 14, scope: !7)
!37 = !DILocation(line: 13, column: 2, scope: !7)
!38 = !DILocation(line: 15, column: 6, scope: !7)
!39 = !DILocation(line: 15, column: 7, scope: !7)
!40 = !DILocation(line: 15, column: 4, scope: !7)
!41 = !DILocation(line: 16, column: 6, scope: !7)
!42 = !DILocation(line: 16, column: 7, scope: !7)
!43 = !DILocation(line: 16, column: 4, scope: !7)
!44 = !DILocation(line: 17, column: 9, scope: !7)
!45 = !DILocation(line: 17, column: 10, scope: !7)
!46 = !DILocation(line: 17, column: 14, scope: !7)
!47 = !DILocation(line: 17, column: 17, scope: !7)
!48 = !DILocation(line: 17, column: 18, scope: !7)
!49 = !DILocation(line: 0, scope: !7)
!50 = !DILocation(line: 17, column: 2, scope: !7)
!51 = !DILocalVariable(name: "res3", scope: !7, file: !1, line: 19, type: !10)
!52 = !DILocation(line: 19, column: 6, scope: !7)
!53 = !DILocation(line: 19, column: 13, scope: !7)
!54 = !DILocation(line: 19, column: 15, scope: !7)
!55 = !DILocation(line: 19, column: 14, scope: !7)
!56 = !DILocation(line: 20, column: 9, scope: !7)
!57 = !DILocation(line: 20, column: 14, scope: !7)
!58 = !DILocation(line: 20, column: 2, scope: !7)
!59 = !DILocalVariable(name: "res4", scope: !7, file: !1, line: 22, type: !10)
!60 = !DILocation(line: 22, column: 6, scope: !7)
!61 = !DILocation(line: 22, column: 14, scope: !7)
!62 = !DILocation(line: 22, column: 13, scope: !7)
!63 = !DILocation(line: 23, column: 9, scope: !7)
!64 = !DILocation(line: 23, column: 14, scope: !7)
!65 = !DILocation(line: 23, column: 2, scope: !7)
!66 = !DILocation(line: 25, column: 2, scope: !7)
