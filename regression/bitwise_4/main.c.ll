; ModuleID = 'bitwise_4/main.c'
source_filename = "bitwise_4/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %x = alloca i32, align 4
  %y = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !11, metadata !DIExpression()), !dbg !12
  store i32 35, i32* %x, align 4, !dbg !12
  %0 = load i32, i32* %x, align 4, !dbg !13
  %neg = xor i32 %0, -1, !dbg !14
  store i32 %neg, i32* %x, align 4, !dbg !15
  %1 = load i32, i32* %x, align 4, !dbg !16
  %cmp = icmp eq i32 %1, -36, !dbg !17
  %conv = zext i1 %cmp to i32, !dbg !17
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !18
  call void @llvm.dbg.declare(metadata i32* %y, metadata !19, metadata !DIExpression()), !dbg !20
  store i32 11, i32* %y, align 4, !dbg !20
  %2 = load i32, i32* %y, align 4, !dbg !21
  %cmp1 = icmp eq i32 %2, 11, !dbg !22
  %conv2 = zext i1 %cmp1 to i32, !dbg !22
  %call3 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv2), !dbg !23
  %3 = load i32, i32* %x, align 4, !dbg !24
  %4 = load i32, i32* %y, align 4, !dbg !25
  %5 = load i32, i32* %x, align 4, !dbg !26
  %neg4 = xor i32 %5, -1, !dbg !27
  %6 = load i32, i32* %y, align 4, !dbg !28
  %and = and i32 %neg4, %6, !dbg !29
  %cmp5 = icmp eq i32 %4, %and, !dbg !30
  %conv6 = zext i1 %cmp5 to i32, !dbg !30
  %xor = xor i32 %3, %conv6, !dbg !31
  %7 = load i32, i32* %x, align 4, !dbg !32
  %8 = load i32, i32* %y, align 4, !dbg !33
  %neg7 = xor i32 %8, -1, !dbg !34
  %and8 = and i32 %7, %neg7, !dbg !35
  %or = or i32 %xor, %and8, !dbg !36
  %call9 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %or), !dbg !37
  ret i32 0, !dbg !38
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
!1 = !DIFile(filename: "bitwise_4/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !8, isLocal: false, isDefinition: true, scopeLine: 2, isOptimized: false, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "x", scope: !7, file: !1, line: 3, type: !10)
!12 = !DILocation(line: 3, column: 6, scope: !7)
!13 = !DILocation(line: 4, column: 7, scope: !7)
!14 = !DILocation(line: 4, column: 6, scope: !7)
!15 = !DILocation(line: 4, column: 4, scope: !7)
!16 = !DILocation(line: 5, column: 9, scope: !7)
!17 = !DILocation(line: 5, column: 11, scope: !7)
!18 = !DILocation(line: 5, column: 2, scope: !7)
!19 = !DILocalVariable(name: "y", scope: !7, file: !1, line: 7, type: !10)
!20 = !DILocation(line: 7, column: 9, scope: !7)
!21 = !DILocation(line: 8, column: 12, scope: !7)
!22 = !DILocation(line: 8, column: 13, scope: !7)
!23 = !DILocation(line: 8, column: 5, scope: !7)
!24 = !DILocation(line: 10, column: 9, scope: !7)
!25 = !DILocation(line: 10, column: 13, scope: !7)
!26 = !DILocation(line: 10, column: 20, scope: !7)
!27 = !DILocation(line: 10, column: 19, scope: !7)
!28 = !DILocation(line: 10, column: 24, scope: !7)
!29 = !DILocation(line: 10, column: 22, scope: !7)
!30 = !DILocation(line: 10, column: 15, scope: !7)
!31 = !DILocation(line: 10, column: 11, scope: !7)
!32 = !DILocation(line: 10, column: 30, scope: !7)
!33 = !DILocation(line: 10, column: 35, scope: !7)
!34 = !DILocation(line: 10, column: 34, scope: !7)
!35 = !DILocation(line: 10, column: 32, scope: !7)
!36 = !DILocation(line: 10, column: 27, scope: !7)
!37 = !DILocation(line: 10, column: 2, scope: !7)
!38 = !DILocation(line: 11, column: 2, scope: !7)
