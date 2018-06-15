; ModuleID = 'assume1/main.c'
source_filename = "assume1/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %x = alloca i32, align 4
  call void @llvm.dbg.declare(metadata i32* %x, metadata !10, metadata !11), !dbg !12
  %0 = load i32, i32* %x, align 4, !dbg !13
  %cmp = icmp sge i32 %0, 0, !dbg !14
  %conv = zext i1 %cmp to i32, !dbg !14
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %conv), !dbg !15
  %1 = load i32, i32* %x, align 4, !dbg !16
  %cmp1 = icmp sge i32 %1, 0, !dbg !17
  %conv2 = zext i1 %cmp1 to i32, !dbg !17
  %call3 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv2), !dbg !18
  %2 = load i32, i32* %x, align 4, !dbg !19
  %cmp4 = icmp eq i32 %2, 1, !dbg !20
  %conv5 = zext i1 %cmp4 to i32, !dbg !20
  %call6 = call i32 (i32, ...) bitcast (i32 (...)* @assume to i32 (i32, ...)*)(i32 %conv5), !dbg !21
  %3 = load i32, i32* %x, align 4, !dbg !22
  %cmp7 = icmp eq i32 %3, 1, !dbg !23
  %conv8 = zext i1 %cmp7 to i32, !dbg !23
  %call9 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv8), !dbg !24
  ret i32 0, !dbg !25
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assume(...) #2

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "assume1/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !7, isLocal: false, isDefinition: true, scopeLine: 2, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "x", scope: !6, file: !1, line: 3, type: !9)
!11 = !DIExpression()
!12 = !DILocation(line: 3, column: 7, scope: !6)
!13 = !DILocation(line: 5, column: 10, scope: !6)
!14 = !DILocation(line: 5, column: 11, scope: !6)
!15 = !DILocation(line: 5, column: 3, scope: !6)
!16 = !DILocation(line: 6, column: 10, scope: !6)
!17 = !DILocation(line: 6, column: 11, scope: !6)
!18 = !DILocation(line: 6, column: 3, scope: !6)
!19 = !DILocation(line: 11, column: 10, scope: !6)
!20 = !DILocation(line: 11, column: 11, scope: !6)
!21 = !DILocation(line: 11, column: 3, scope: !6)
!22 = !DILocation(line: 12, column: 10, scope: !6)
!23 = !DILocation(line: 12, column: 11, scope: !6)
!24 = !DILocation(line: 12, column: 3, scope: !6)
!25 = !DILocation(line: 13, column: 1, scope: !6)
