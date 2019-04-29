; ModuleID = 'function_pointer2/main.c'
source_filename = "function_pointer2/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.device = type { i32 (...)* }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @one() #0 !dbg !7 {
entry:
  ret i32 1, !dbg !11
}

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !12 {
entry:
  %devices = alloca [1 x %struct.device], align 8
  %x = alloca i32, align 4
  call void @llvm.dbg.declare(metadata [1 x %struct.device]* %devices, metadata !13, metadata !DIExpression()), !dbg !23
  call void @llvm.dbg.declare(metadata i32* %x, metadata !24, metadata !DIExpression()), !dbg !25
  %arrayidx = getelementptr inbounds [1 x %struct.device], [1 x %struct.device]* %devices, i64 0, i64 0, !dbg !26
  %func = getelementptr inbounds %struct.device, %struct.device* %arrayidx, i32 0, i32 0, !dbg !27
  store i32 (...)* bitcast (i32 ()* @one to i32 (...)*), i32 (...)** %func, align 8, !dbg !28
  %arrayidx1 = getelementptr inbounds [1 x %struct.device], [1 x %struct.device]* %devices, i64 0, i64 0, !dbg !29
  %func2 = getelementptr inbounds %struct.device, %struct.device* %arrayidx1, i32 0, i32 0, !dbg !30
  %0 = load i32 (...)*, i32 (...)** %func2, align 8, !dbg !30
  %call = call i32 (...) %0(), !dbg !31
  store i32 %call, i32* %x, align 4, !dbg !32
  %1 = load i32, i32* %x, align 4, !dbg !33
  %cmp = icmp eq i32 %1, 1, !dbg !34
  %conv = zext i1 %cmp to i32, !dbg !34
  %call3 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !35
  ret i32 0, !dbg !36
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
!1 = !DIFile(filename: "function_pointer2/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "one", scope: !1, file: !1, line: 5, type: !8, scopeLine: 6, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocation(line: 7, column: 3, scope: !7)
!12 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 10, type: !8, scopeLine: 11, flags: DIFlagPrototyped, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!13 = !DILocalVariable(name: "devices", scope: !12, file: !1, line: 12, type: !14)
!14 = !DICompositeType(tag: DW_TAG_array_type, baseType: !15, size: 64, elements: !21)
!15 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "device", file: !1, line: 1, size: 64, elements: !16)
!16 = !{!17}
!17 = !DIDerivedType(tag: DW_TAG_member, name: "func", scope: !15, file: !1, line: 2, baseType: !18, size: 64)
!18 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !19, size: 64)
!19 = !DISubroutineType(types: !20)
!20 = !{!10, null}
!21 = !{!22}
!22 = !DISubrange(count: 1)
!23 = !DILocation(line: 12, column: 17, scope: !12)
!24 = !DILocalVariable(name: "x", scope: !12, file: !1, line: 13, type: !10)
!25 = !DILocation(line: 13, column: 7, scope: !12)
!26 = !DILocation(line: 15, column: 3, scope: !12)
!27 = !DILocation(line: 15, column: 14, scope: !12)
!28 = !DILocation(line: 15, column: 19, scope: !12)
!29 = !DILocation(line: 17, column: 8, scope: !12)
!30 = !DILocation(line: 17, column: 19, scope: !12)
!31 = !DILocation(line: 17, column: 5, scope: !12)
!32 = !DILocation(line: 17, column: 4, scope: !12)
!33 = !DILocation(line: 18, column: 10, scope: !12)
!34 = !DILocation(line: 18, column: 12, scope: !12)
!35 = !DILocation(line: 18, column: 3, scope: !12)
!36 = !DILocation(line: 19, column: 1, scope: !12)
