; ModuleID = 'Function12/main.c'
source_filename = "Function12/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @f(i32 %x) #0 !dbg !7 {
entry:
  %x.addr = alloca i32, align 4
  store i32 %x, i32* %x.addr, align 4
  call void @llvm.dbg.declare(metadata i32* %x.addr, metadata !11, metadata !DIExpression()), !dbg !12
  %0 = load i32, i32* %x.addr, align 4, !dbg !13
  %add = add nsw i32 %0, 1, !dbg !14
  ret i32 %add, !dbg !15
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !16 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !19, metadata !DIExpression()), !dbg !20
  %call = call i32 @f(i32 2), !dbg !21
  store i32 %call, i32* %a, align 4, !dbg !22
  %0 = load i32, i32* %a, align 4, !dbg !23
  %cmp = icmp eq i32 %0, 3, !dbg !24
  %conv = zext i1 %cmp to i32, !dbg !24
  %call1 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !25
  ret i32 0, !dbg !26
}

declare dso_local i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "Function12/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 7.0.1 (https://github.com/llvm-mirror/clang.git 4519e2637fcc4bf6e3049a0a80e6a5e7b97667cb) (https://github.com/llvm-mirror/llvm.git cd98f42d0747826062fc3d2d2fad383aedf58dd6)"}
!7 = distinct !DISubprogram(name: "f", scope: !1, file: !1, line: 1, type: !8, isLocal: false, isDefinition: true, scopeLine: 1, flags: DIFlagPrototyped, isOptimized: false, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "x", arg: 1, scope: !7, file: !1, line: 1, type: !10)
!12 = !DILocation(line: 1, column: 11, scope: !7)
!13 = !DILocation(line: 2, column: 12, scope: !7)
!14 = !DILocation(line: 2, column: 13, scope: !7)
!15 = !DILocation(line: 2, column: 5, scope: !7)
!16 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 5, type: !17, isLocal: false, isDefinition: true, scopeLine: 6, isOptimized: false, unit: !0, retainedNodes: !2)
!17 = !DISubroutineType(types: !18)
!18 = !{!10}
!19 = !DILocalVariable(name: "a", scope: !16, file: !1, line: 7, type: !10)
!20 = !DILocation(line: 7, column: 7, scope: !16)
!21 = !DILocation(line: 8, column: 7, scope: !16)
!22 = !DILocation(line: 8, column: 5, scope: !16)
!23 = !DILocation(line: 9, column: 10, scope: !16)
!24 = !DILocation(line: 9, column: 12, scope: !16)
!25 = !DILocation(line: 9, column: 3, scope: !16)
!26 = !DILocation(line: 10, column: 3, scope: !16)