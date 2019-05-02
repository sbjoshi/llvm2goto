; ModuleID = 'akash_struct_1/main.c'
source_filename = "akash_struct_1/main.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.test1 = type { i32, i32 }
%struct.test2 = type { i32, i32 }

; Function Attrs: noinline nounwind optnone uwtable
define dso_local i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %x1 = alloca %struct.test1, align 4
  %x2 = alloca %struct.test2, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.test1* %x1, metadata !11, metadata !DIExpression()), !dbg !17
  call void @llvm.dbg.declare(metadata %struct.test2* %x2, metadata !18, metadata !DIExpression()), !dbg !23
  %a = getelementptr inbounds %struct.test1, %struct.test1* %x1, i32 0, i32 0, !dbg !24
  store i32 -10, i32* %a, align 4, !dbg !25
  %b = getelementptr inbounds %struct.test1, %struct.test1* %x1, i32 0, i32 1, !dbg !26
  store i32 20, i32* %b, align 4, !dbg !27
  %c = getelementptr inbounds %struct.test2, %struct.test2* %x2, i32 0, i32 0, !dbg !28
  store i32 -30, i32* %c, align 4, !dbg !29
  %d = getelementptr inbounds %struct.test2, %struct.test2* %x2, i32 0, i32 1, !dbg !30
  store i32 40, i32* %d, align 4, !dbg !31
  %a1 = getelementptr inbounds %struct.test1, %struct.test1* %x1, i32 0, i32 0, !dbg !32
  %0 = load i32, i32* %a1, align 4, !dbg !32
  %cmp = icmp eq i32 %0, -10, !dbg !33
  %conv = zext i1 %cmp to i32, !dbg !33
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !34
  %b2 = getelementptr inbounds %struct.test1, %struct.test1* %x1, i32 0, i32 1, !dbg !35
  %1 = load i32, i32* %b2, align 4, !dbg !35
  %cmp3 = icmp eq i32 %1, 20, !dbg !36
  %conv4 = zext i1 %cmp3 to i32, !dbg !36
  %call5 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv4), !dbg !37
  %c6 = getelementptr inbounds %struct.test2, %struct.test2* %x2, i32 0, i32 0, !dbg !38
  %2 = load i32, i32* %c6, align 4, !dbg !38
  %cmp7 = icmp eq i32 %2, -30, !dbg !39
  %conv8 = zext i1 %cmp7 to i32, !dbg !39
  %call9 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv8), !dbg !40
  %d10 = getelementptr inbounds %struct.test2, %struct.test2* %x2, i32 0, i32 1, !dbg !41
  %3 = load i32, i32* %d10, align 4, !dbg !41
  %cmp11 = icmp eq i32 %3, 40, !dbg !42
  %conv12 = zext i1 %cmp11 to i32, !dbg !42
  %call13 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv12), !dbg !43
  ret i32 0, !dbg !44
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
!1 = !DIFile(filename: "akash_struct_1/main.c", directory: "/home/akash/Documents/CBMC/cbmc/src/llvm2goto/regression")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 8.0.0 "}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 10, type: !8, scopeLine: 11, spFlags: DISPFlagDefinition, unit: !0, retainedNodes: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "x1", scope: !7, file: !1, line: 12, type: !12)
!12 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "test1", file: !1, line: 5, size: 64, elements: !13)
!13 = !{!14, !15}
!14 = !DIDerivedType(tag: DW_TAG_member, name: "a", scope: !12, file: !1, line: 6, baseType: !10, size: 32)
!15 = !DIDerivedType(tag: DW_TAG_member, name: "b", scope: !12, file: !1, line: 7, baseType: !16, size: 32, offset: 32)
!16 = !DIBasicType(name: "unsigned int", size: 32, encoding: DW_ATE_unsigned)
!17 = !DILocation(line: 12, column: 18, scope: !7)
!18 = !DILocalVariable(name: "x2", scope: !7, file: !1, line: 13, type: !19)
!19 = distinct !DICompositeType(tag: DW_TAG_structure_type, name: "test2", file: !1, line: 1, size: 64, elements: !20)
!20 = !{!21, !22}
!21 = !DIDerivedType(tag: DW_TAG_member, name: "c", scope: !19, file: !1, line: 2, baseType: !10, size: 32)
!22 = !DIDerivedType(tag: DW_TAG_member, name: "d", scope: !19, file: !1, line: 3, baseType: !16, size: 32, offset: 32)
!23 = !DILocation(line: 13, column: 18, scope: !7)
!24 = !DILocation(line: 14, column: 8, scope: !7)
!25 = !DILocation(line: 14, column: 10, scope: !7)
!26 = !DILocation(line: 15, column: 8, scope: !7)
!27 = !DILocation(line: 15, column: 10, scope: !7)
!28 = !DILocation(line: 16, column: 8, scope: !7)
!29 = !DILocation(line: 16, column: 10, scope: !7)
!30 = !DILocation(line: 17, column: 8, scope: !7)
!31 = !DILocation(line: 17, column: 10, scope: !7)
!32 = !DILocation(line: 18, column: 15, scope: !7)
!33 = !DILocation(line: 18, column: 17, scope: !7)
!34 = !DILocation(line: 18, column: 5, scope: !7)
!35 = !DILocation(line: 19, column: 15, scope: !7)
!36 = !DILocation(line: 19, column: 17, scope: !7)
!37 = !DILocation(line: 19, column: 5, scope: !7)
!38 = !DILocation(line: 20, column: 15, scope: !7)
!39 = !DILocation(line: 20, column: 17, scope: !7)
!40 = !DILocation(line: 20, column: 5, scope: !7)
!41 = !DILocation(line: 21, column: 15, scope: !7)
!42 = !DILocation(line: 21, column: 17, scope: !7)
!43 = !DILocation(line: 21, column: 5, scope: !7)
!44 = !DILocation(line: 22, column: 2, scope: !7)
