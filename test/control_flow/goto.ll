; ModuleID = 'control_flow/goto.c'
source_filename = "control_flow/goto.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !6 {
entry:
  %retval = alloca i32, align 4
  %i = alloca i32, align 4
  %j = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %i, metadata !10, metadata !11), !dbg !12
  call void @llvm.dbg.declare(metadata i32* %j, metadata !13, metadata !11), !dbg !14
  store i32 0, i32* %j, align 4, !dbg !14
  store i32 9, i32* %i, align 4, !dbg !15
  br label %mew, !dbg !16

mew:                                              ; preds = %entry
  %0 = load i32, i32* %j, align 4, !dbg !17
  store i32 %0, i32* %i, align 4, !dbg !18
  ret i32 0, !dbg !19
}

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "control_flow/goto.c", directory: "/home/rasika/Downloads/llvm_clang/build/bin")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !7, isLocal: false, isDefinition: true, scopeLine: 1, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocalVariable(name: "i", scope: !6, file: !1, line: 2, type: !9)
!11 = !DIExpression()
!12 = !DILocation(line: 2, column: 6, scope: !6)
!13 = !DILocalVariable(name: "j", scope: !6, file: !1, line: 2, type: !9)
!14 = !DILocation(line: 2, column: 9, scope: !6)
!15 = !DILocation(line: 3, column: 4, scope: !6)
!16 = !DILocation(line: 4, column: 2, scope: !6)
!17 = !DILocation(line: 7, column: 6, scope: !6)
!18 = !DILocation(line: 7, column: 4, scope: !6)
!19 = !DILocation(line: 8, column: 2, scope: !6)
