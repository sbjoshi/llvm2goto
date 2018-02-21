; ModuleID = '2005-11-29-LongSwitch.c'
source_filename = "2005-11-29-LongSwitch.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @foo(i64 %v) #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %v.addr = alloca i64, align 8
  store i64 %v, i64* %v.addr, align 8
  call void @llvm.dbg.declare(metadata i64* %v.addr, metadata !12, metadata !13), !dbg !14
  %0 = load i64, i64* %v.addr, align 8, !dbg !15
  switch i64 %0, label %sw.epilog [
    i64 0, label %sw.bb
    i64 -1, label %sw.bb1
  ], !dbg !16

sw.bb:                                            ; preds = %entry
  store i32 1, i32* %retval, align 4, !dbg !17
  br label %return, !dbg !17

sw.bb1:                                           ; preds = %entry
  store i32 2, i32* %retval, align 4, !dbg !19
  br label %return, !dbg !19

sw.epilog:                                        ; preds = %entry
  store i32 0, i32* %retval, align 4, !dbg !20
  br label %return, !dbg !20

return:                                           ; preds = %sw.epilog, %sw.bb1, %sw.bb
  %1 = load i32, i32* %retval, align 4, !dbg !21
  ret i32 %1, !dbg !21
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !22 {
entry:
  %retval = alloca i32, align 4
  %r = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %r, metadata !25, metadata !13), !dbg !26
  %call = call i32 @foo(i64 4294967295), !dbg !27
  store i32 %call, i32* %r, align 4, !dbg !26
  %0 = load i32, i32* %r, align 4, !dbg !28
  %cmp = icmp eq i32 %0, 0, !dbg !29
  %conv = zext i1 %cmp to i32, !dbg !29
  %call1 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !30
  %1 = load i32, i32* %r, align 4, !dbg !31
  ret i32 %1, !dbg !32
}

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "2005-11-29-LongSwitch.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "foo", scope: !1, file: !1, line: 5, type: !8, isLocal: false, isDefinition: true, scopeLine: 5, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10, !11}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DIBasicType(name: "long long int", size: 64, encoding: DW_ATE_signed)
!12 = !DILocalVariable(name: "v", arg: 1, scope: !7, file: !1, line: 5, type: !11)
!13 = !DIExpression()
!14 = !DILocation(line: 5, column: 19, scope: !7)
!15 = !DILocation(line: 6, column: 13, scope: !7)
!16 = !DILocation(line: 6, column: 5, scope: !7)
!17 = !DILocation(line: 8, column: 9, scope: !18)
!18 = distinct !DILexicalBlock(scope: !7, file: !1, line: 6, column: 16)
!19 = !DILocation(line: 10, column: 9, scope: !18)
!20 = !DILocation(line: 12, column: 5, scope: !7)
!21 = !DILocation(line: 13, column: 1, scope: !7)
!22 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 15, type: !23, isLocal: false, isDefinition: true, scopeLine: 15, isOptimized: false, unit: !0, variables: !2)
!23 = !DISubroutineType(types: !24)
!24 = !{!10}
!25 = !DILocalVariable(name: "r", scope: !22, file: !1, line: 16, type: !10)
!26 = !DILocation(line: 16, column: 9, scope: !22)
!27 = !DILocation(line: 16, column: 13, scope: !22)
!28 = !DILocation(line: 18, column: 12, scope: !22)
!29 = !DILocation(line: 18, column: 14, scope: !22)
!30 = !DILocation(line: 18, column: 5, scope: !22)
!31 = !DILocation(line: 19, column: 12, scope: !22)
!32 = !DILocation(line: 19, column: 5, scope: !22)
