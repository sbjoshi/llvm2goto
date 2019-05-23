; ModuleID = 'akash_struct_2/main.c'
source_filename = "akash_struct_2/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.test2 = type { i32 }
%struct.test = type { i32, [20 x [30 x i32]], i8 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %new = alloca %struct.test2, align 4
  %var = alloca %struct.test, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.test2* %new, metadata !11, metadata !DIExpression()), !dbg !15
  call void @llvm.dbg.declare(metadata %struct.test* %var, metadata !16, metadata !DIExpression()), !dbg !27
  %c = getelementptr inbounds %struct.test2, %struct.test2* %new, i32 0, i32 0, !dbg !28
  store i32 35, i32* %c, align 4, !dbg !29
  %b = getelementptr inbounds %struct.test, %struct.test* %var, i32 0, i32 1, !dbg !30
  %arrayidx = getelementptr inbounds [20 x [30 x i32]], [20 x [30 x i32]]* %b, i64 0, i64 10, !dbg !31
  %arrayidx1 = getelementptr inbounds [30 x i32], [30 x i32]* %arrayidx, i64 0, i64 5, !dbg !31
  store i32 35, i32* %arrayidx1, align 4, !dbg !32
  %b2 = getelementptr inbounds %struct.test, %struct.test* %var, i32 0, i32 1, !dbg !33
  %arrayidx3 = getelementptr inbounds [20 x [30 x i32]], [20 x [30 x i32]]* %b2, i64 0, i64 10, !dbg !34
  %arrayidx4 = getelementptr inbounds [30 x i32], [30 x i32]* %arrayidx3, i64 0, i64 5, !dbg !34
  %0 = load i32, i32* %arrayidx4, align 4, !dbg !34
  %c5 = getelementptr inbounds %struct.test2, %struct.test2* %new, i32 0, i32 0, !dbg !35
  %1 = load i32, i32* %c5, align 4, !dbg !35
  %cmp = icmp eq i32 %0, %1, !dbg !36
  %conv = zext i1 %cmp to i32, !dbg !36
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !37
  ret i32 0, !dbg !38
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
!1 = !DIFile(filename: "akash_struct_2/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 12, type: !8, scopeLine: 13, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "new", scope: !7, file: !1, line: 15, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "test2", file: !1, line: 3, size: 32, elements: !13)
!13 = !{!14}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !12, file: !1, line: 4, baseType: !10, size: 32)
!15 = !DILocation(line: 15, column: 18, scope: !7)
!16 = !DILocalVariable(name: "var", scope: !7, file: !1, line: 16, type: !17)
!17 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "test", file: !1, line: 6, size: 19264, elements: !18)
!18 = !{!19, !20, !25}
!19 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !17, file: !1, line: 7, baseType: !10, size: 32)
!20 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !17, file: !1, line: 8, baseType: !21, size: 19200, offset: 32)
!21 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 19200, elements: !22)
!22 = !{!23, !24}
!23 = !DISubrange(count: 20)
!24 = !DISubrange(count: 30)
!25 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !17, file: !1, line: 9, baseType: !26, size: 8, offset: 19232)
!26 = !DIBasicType(name: "char", size: 8, encoding: DW_ATE_signed_char)
!27 = !DILocation(line: 16, column: 17, scope: !7)
!28 = !DILocation(line: 17, column: 9, scope: !7)
!29 = !DILocation(line: 17, column: 11, scope: !7)
!30 = !DILocation(line: 18, column: 9, scope: !7)
!31 = !DILocation(line: 18, column: 5, scope: !7)
!32 = !DILocation(line: 18, column: 18, scope: !7)
!33 = !DILocation(line: 19, column: 16, scope: !7)
!34 = !DILocation(line: 19, column: 12, scope: !7)
!35 = !DILocation(line: 19, column: 32, scope: !7)
!36 = !DILocation(line: 19, column: 25, scope: !7)
!37 = !DILocation(line: 19, column: 5, scope: !7)
!38 = !DILocation(line: 20, column: 2, scope: !7)
