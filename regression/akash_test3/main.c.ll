; ModuleID = 'akash_test3/main.c'
source_filename = "akash_test3/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %a = alloca i32, align 4
  %b = alloca i32, align 4
  %c = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata i32* %a, metadata !11, metadata !DIExpression()), !dbg !12
  store i32 2, i32* %a, align 4, !dbg !12
  call void @llvm.dbg.declare(metadata i32* %b, metadata !13, metadata !DIExpression()), !dbg !14
  store i32 2, i32* %b, align 4, !dbg !14
  call void @llvm.dbg.declare(metadata i32* %c, metadata !15, metadata !DIExpression()), !dbg !16
  store i32 2, i32* %c, align 4, !dbg !16
  %0 = load i32, i32* %a, align 4, !dbg !17
  %tobool = icmp ne i32 %0, 0, !dbg !17
  br i1 %tobool, label %land.rhs, label %land.end, !dbg !18

land.rhs:                                         ; preds = %entry
  %1 = load i32, i32* %b, align 4, !dbg !19
  %tobool1 = icmp ne i32 %1, 0, !dbg !18
  br label %land.end

land.end:                                         ; preds = %land.rhs, %entry
  %2 = phi i1 [ false, %entry ], [ %tobool1, %land.rhs ], !dbg !20
  %land.ext = zext i1 %2 to i32, !dbg !18
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %land.ext), !dbg !21
  %3 = load i32, i32* %retval, align 4, !dbg !22
  ret i32 %3, !dbg !22
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
!1 = !DIFile(filename: "akash_test3/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 2, type: !8, scopeLine: 3, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "a", scope: !7, file: !1, line: 4, type: !10)
!12 = !DILocation(line: 4, column: 9, scope: !7)
!13 = !DILocalVariable(name: "b", scope: !7, file: !1, line: 4, type: !10)
!14 = !DILocation(line: 4, column: 16, scope: !7)
!15 = !DILocalVariable(name: "c", scope: !7, file: !1, line: 4, type: !10)
!16 = !DILocation(line: 4, column: 23, scope: !7)
!17 = !DILocation(line: 5, column: 12, scope: !7)
!18 = !DILocation(line: 5, column: 14, scope: !7)
!19 = !DILocation(line: 5, column: 17, scope: !7)
!20 = !DILocation(line: 0, scope: !7)
!21 = !DILocation(line: 5, column: 5, scope: !7)
!22 = !DILocation(line: 6, column: 1, scope: !7)
