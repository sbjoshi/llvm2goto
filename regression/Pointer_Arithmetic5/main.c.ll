; ModuleID = 'Pointer_Arithmetic5/main.c'
source_filename = "Pointer_Arithmetic5/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %array = alloca [3 x [3 x i32]], align 16
  %x = alloca i32, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [3 x [3 x i32]]* %array, metadata !11, metadata !DIExpression()), !dbg !15
  %arrayidx = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %array, i64 0, i64 1, !dbg !16
  %arrayidx1 = getelementptr inbounds [3 x i32], [3 x i32]* %arrayidx, i64 0, i64 2, !dbg !16
  store i32 10, i32* %arrayidx1, align 4, !dbg !17
  call void @llvm.dbg.declare(metadata i32* %x, metadata !18, metadata !DIExpression()), !dbg !19
  %arraydecay = getelementptr inbounds [3 x [3 x i32]], [3 x [3 x i32]]* %array, i32 0, i32 0, !dbg !20
  %add.ptr = getelementptr inbounds [3 x i32], [3 x i32]* %arraydecay, i64 1, !dbg !21
  %arraydecay2 = getelementptr inbounds [3 x i32], [3 x i32]* %add.ptr, i32 0, i32 0, !dbg !22
  %add.ptr3 = getelementptr inbounds i32, i32* %arraydecay2, i64 2, !dbg !23
  %0 = load i32, i32* %add.ptr3, align 4, !dbg !24
  store i32 %0, i32* %x, align 4, !dbg !19
  %1 = load i32, i32* %x, align 4, !dbg !25
  %cmp = icmp eq i32 %1, 10, !dbg !26
  %conv = zext i1 %cmp to i32, !dbg !26
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !27
  ret i32 0, !dbg !28
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
!1 = !DIFile(filename: "Pointer_Arithmetic5/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 1, type: !8, scopeLine: 2, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "array", scope: !7, file: !1, line: 3, type: !12)
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 288, elements: !13)
!13 = !{!14, !14}
!14 = !DISubrange(count: 3)
!15 = !DILocation(line: 3, column: 6, scope: !7)
!16 = !DILocation(line: 5, column: 2, scope: !7)
!17 = !DILocation(line: 5, column: 14, scope: !7)
!18 = !DILocalVariable(name: "x", scope: !7, file: !1, line: 7, type: !10)
!19 = !DILocation(line: 7, column: 6, scope: !7)
!20 = !DILocation(line: 7, column: 14, scope: !7)
!21 = !DILocation(line: 7, column: 19, scope: !7)
!22 = !DILocation(line: 7, column: 12, scope: !7)
!23 = !DILocation(line: 7, column: 22, scope: !7)
!24 = !DILocation(line: 7, column: 10, scope: !7)
!25 = !DILocation(line: 8, column: 9, scope: !7)
!26 = !DILocation(line: 8, column: 10, scope: !7)
!27 = !DILocation(line: 8, column: 2, scope: !7)
!28 = !DILocation(line: 10, column: 2, scope: !7)
