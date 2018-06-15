; ModuleID = 'function_pointer2/main.c'
source_filename = "function_pointer2/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.device = type { i32 (...)* }

; Function Attrs: noinline nounwind uwtable
define i32 @one() #0 !dbg !6 {
entry:
  ret i32 1, !dbg !10
}

; Function Attrs: noinline nounwind uwtable
define i32 @main() #0 !dbg !11 {
entry:
  %devices = alloca [1 x %struct.device], align 8
  %x = alloca i32, align 4
  call void @llvm.dbg.declare(metadata [1 x %struct.device]* %devices, metadata !12, metadata !22), !dbg !23
  call void @llvm.dbg.declare(metadata i32* %x, metadata !24, metadata !22), !dbg !25
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

; Function Attrs: nounwind readnone
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4}
!llvm.ident = !{!5}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.0 (trunk 295264)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "function_pointer2/main.c", directory: "/home/rasika/llvm2goto/llvm2goto-regression-master")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{!"clang version 5.0.0 (trunk 295264)"}
!6 = distinct !DISubprogram(name: "one", scope: !1, file: !1, line: 5, type: !7, isLocal: false, isDefinition: true, scopeLine: 6, isOptimized: false, unit: !0, variables: !2)
!7 = !DISubroutineType(types: !8)
!8 = !{!9}
!9 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!10 = !DILocation(line: 7, column: 3, scope: !6)
!11 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 10, type: !7, isLocal: false, isDefinition: true, scopeLine: 11, flags: DIFlagPrototyped, isOptimized: false, unit: !0, variables: !2)
!12 = !DILocalVariable(name: "devices", scope: !11, file: !1, line: 12, type: !13)
!13 = !DICompositeType(tag: DW_TAG_array_type, baseType: !14, size: 64, elements: !20)
!14 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "device", file: !1, line: 1, size: 64, elements: !15)
!15 = !{!16}
!16 = !DIDerivedType(tag: DW_TAG_member, name: "func", scope: !14, file: !1, line: 2, baseType: !17, size: 64)
!17 = !DIDerivedType(tag: DW_TAG_pointer_type, baseType: !18, size: 64)
!18 = !DISubroutineType(types: !19)
!19 = !{!9, null}
!20 = !{!21}
!21 = !DISubrange(count: 1)
!22 = !DIExpression()
!23 = !DILocation(line: 12, column: 17, scope: !11)
!24 = !DILocalVariable(name: "x", scope: !11, file: !1, line: 13, type: !9)
!25 = !DILocation(line: 13, column: 7, scope: !11)
!26 = !DILocation(line: 15, column: 3, scope: !11)
!27 = !DILocation(line: 15, column: 14, scope: !11)
!28 = !DILocation(line: 15, column: 19, scope: !11)
!29 = !DILocation(line: 17, column: 8, scope: !11)
!30 = !DILocation(line: 17, column: 19, scope: !11)
!31 = !DILocation(line: 17, column: 5, scope: !11)
!32 = !DILocation(line: 17, column: 4, scope: !11)
!33 = !DILocation(line: 18, column: 10, scope: !11)
!34 = !DILocation(line: 18, column: 12, scope: !11)
!35 = !DILocation(line: 18, column: 3, scope: !11)
!36 = !DILocation(line: 19, column: 1, scope: !11)
