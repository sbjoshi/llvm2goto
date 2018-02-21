; ModuleID = '2003-10-13-SwitchTest.c'
source_filename = "2003-10-13-SwitchTest.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @test() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !11, metadata !12), !dbg !13
  %0 = load i32, i32* %i, align 4, !dbg !14
  switch i32 %0, label %sw.default [
    i32 100, label %sw.bb
    i32 101, label %sw.bb
    i32 1023, label %sw.bb
  ], !dbg !15

sw.default:                                       ; preds = %entry
  store i32 0, i32* %retval, align 4, !dbg !16
  br label %return, !dbg !16

sw.bb:                                            ; preds = %entry, %entry, %entry
  store i32 1, i32* %retval, align 4, !dbg !18
  br label %return, !dbg !18

return:                                           ; preds = %sw.bb, %sw.default
  %1 = load i32, i32* %retval, align 4, !dbg !19
  ret i32 %1, !dbg !19
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !20 {
entry:
  %retval = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  %call = call i32 @test(), !dbg !21
  %cmp = icmp eq i32 %call, 1, !dbg !22
  %conv = zext i1 %cmp to i32, !dbg !22
  %call1 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !23
  ret i32 0, !dbg !24
}

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "2003-10-13-SwitchTest.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/unit-tests")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "test", scope: !1, file: !1, line: 3, type: !8, isLocal: false, isDefinition: true, scopeLine: 3, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "i", scope: !7, file: !1, line: 4, type: !10)
!12 = !DIExpression()
!13 = !DILocation(line: 4, column: 7, scope: !7)
!14 = !DILocation(line: 5, column: 12, scope: !7)
!15 = !DILocation(line: 5, column: 4, scope: !7)
!16 = !DILocation(line: 8, column: 6, scope: !17)
!17 = distinct !DILexicalBlock(scope: !7, file: !1, line: 5, column: 15)
!18 = !DILocation(line: 13, column: 6, scope: !17)
!19 = !DILocation(line: 15, column: 1, scope: !7)
!20 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 17, type: !8, isLocal: false, isDefinition: true, scopeLine: 17, isOptimized: false, unit: !0, variables: !2)
!21 = !DILocation(line: 18, column: 10, scope: !20)
!22 = !DILocation(line: 18, column: 17, scope: !20)
!23 = !DILocation(line: 18, column: 3, scope: !20)
!24 = !DILocation(line: 19, column: 3, scope: !20)
