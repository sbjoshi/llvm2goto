; ModuleID = 'add.c'
source_filename = "add.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %a = alloca float, align 4
  %b = alloca float, align 4
  %c = alloca float, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata float* %a, metadata !11, metadata !13), !dbg !14
  call void @llvm.dbg.declare(metadata float* %b, metadata !15, metadata !13), !dbg !16
  call void @llvm.dbg.declare(metadata float* %c, metadata !17, metadata !13), !dbg !18
  store float 1.000000e+00, float* %a, align 4, !dbg !19
  store float 2.000000e+00, float* %b, align 4, !dbg !20
  %0 = load float, float* %a, align 4, !dbg !21
  %1 = load float, float* %b, align 4, !dbg !22
  %add = fadd float %0, %1, !dbg !23
  store float %add, float* %c, align 4, !dbg !24
  ret i32 0, !dbg !25
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "add.c", directory: "/home/ubuntu/llvm2goto/regression/c/arithmetic_operations/floating_point")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !8, isLocal: false, isDefinition: true, scopeLine: 1, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 2, type: !12)
!12 = !DIBasicType(name: "float", size: 32, encoding: DW_ATE_float)
!13 = !DIExpression()
!14 = !DILocation(line: 2, column: 8, scope: !7)
!15 = !DILocalVariable(name: "b", scope: !7, file: !1, line: 2, type: !12)
!16 = !DILocation(line: 2, column: 11, scope: !7)
!17 = !DILocalVariable(name: "c", scope: !7, file: !1, line: 2, type: !12)
!18 = !DILocation(line: 2, column: 14, scope: !7)
!19 = !DILocation(line: 3, column: 4, scope: !7)
!20 = !DILocation(line: 4, column: 4, scope: !7)
!21 = !DILocation(line: 5, column: 6, scope: !7)
!22 = !DILocation(line: 5, column: 10, scope: !7)
!23 = !DILocation(line: 5, column: 8, scope: !7)
!24 = !DILocation(line: 5, column: 4, scope: !7)
!25 = !DILocation(line: 8, column: 2, scope: !7)
