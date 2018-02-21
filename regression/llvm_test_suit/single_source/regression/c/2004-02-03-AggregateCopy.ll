; ModuleID = '2004-02-03-AggregateCopy.c'
source_filename = "2004-02-03-AggregateCopy.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

%struct.agg = type { i32 }

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %A = alloca %struct.agg, align 4
  %B = alloca %struct.agg, align 4
  %C = alloca %struct.agg, align 4
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata %struct.agg* %A, metadata !11, metadata !16), !dbg !17
  %X = getelementptr inbounds %struct.agg, %struct.agg* %A, i32 0, i32 0, !dbg !18
  store i32 123, i32* %X, align 4, !dbg !19
  call void @llvm.dbg.declare(metadata %struct.agg* %B, metadata !20, metadata !16), !dbg !21
  call void @llvm.dbg.declare(metadata %struct.agg* %C, metadata !22, metadata !16), !dbg !23
  %0 = bitcast %struct.agg* %C to i8*, !dbg !24
  %1 = bitcast %struct.agg* %A to i8*, !dbg !24
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %0, i8* %1, i64 4, i32 4, i1 false), !dbg !24
  %2 = bitcast %struct.agg* %B to i8*, !dbg !25
  %3 = bitcast %struct.agg* %C to i8*, !dbg !25
  call void @llvm.memcpy.p0i8.p0i8.i64(i8* %2, i8* %3, i64 4, i32 4, i1 false), !dbg !25
  %X1 = getelementptr inbounds %struct.agg, %struct.agg* %A, i32 0, i32 0, !dbg !26
  %4 = load i32, i32* %X1, align 4, !dbg !26
  %cmp = icmp eq i32 %4, 123, !dbg !27
  %conv = zext i1 %cmp to i32, !dbg !27
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !28
  %X2 = getelementptr inbounds %struct.agg, %struct.agg* %B, i32 0, i32 0, !dbg !29
  %5 = load i32, i32* %X2, align 4, !dbg !29
  %cmp3 = icmp eq i32 %5, 123, !dbg !30
  %conv4 = zext i1 %cmp3 to i32, !dbg !30
  %call5 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv4), !dbg !31
  %X6 = getelementptr inbounds %struct.agg, %struct.agg* %C, i32 0, i32 0, !dbg !32
  %6 = load i32, i32* %X6, align 4, !dbg !32
  %cmp7 = icmp eq i32 %6, 123, !dbg !33
  %conv8 = zext i1 %cmp7 to i32, !dbg !33
  %call9 = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv8), !dbg !34
  ret i32 0, !dbg !35
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

; Function Attrs: argmemonly nounwind
declare void @llvm.memcpy.p0i8.p0i8.i64(i8* nocapture writeonly, i8* nocapture readonly, i64, i32, i1) #2

declare i32 @assert(...) #3

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { argmemonly nounwind }
attributes #3 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "2004-02-03-AggregateCopy.c", directory: "/home/ubuntu/llvm2goto/regression/llvm_test_suit/single_source/regression/c")
!2 = !{}
!3 = !{i32 2, !"Dwarf Version", i32 4}
!4 = !{i32 2, !"Debug Info Version", i32 3}
!5 = !{i32 1, !"wchar_size", i32 4}
!6 = !{!"clang version 5.0.1 (tags/RELEASE_501/final)"}
!7 = distinct !DISubprogram(name: "main", scope: !1, file: !1, line: 7, type: !8, isLocal: false, isDefinition: true, scopeLine: 7, isOptimized: false, unit: !0, variables: !2)
!8 = !DISubroutineType(types: !9)
!9 = !{!10}
!10 = !DIBasicType(name: "int", size: 32, encoding: DW_ATE_signed)
!11 = !DILocalVariable(name: "A", scope: !7, file: !1, line: 8, type: !12)
!12 = !DIDerivedType(tag: DW_TAG_typedef, name: "agg", file: !1, line: 5, baseType: !13)
!13 = distinct !DICompositeType(tag: DW_TAG_structure_type, file: !1, line: 3, size: 32, elements: !14)
!14 = !{!15}
!15 = !DIDerivedType(tag: DW_TAG_member, name: "X", scope: !13, file: !1, line: 4, baseType: !10, size: 32)
!16 = !DIExpression()
!17 = !DILocation(line: 8, column: 7, scope: !7)
!18 = !DILocation(line: 8, column: 13, scope: !7)
!19 = !DILocation(line: 8, column: 15, scope: !7)
!20 = !DILocalVariable(name: "B", scope: !7, file: !1, line: 9, type: !12)
!21 = !DILocation(line: 9, column: 7, scope: !7)
!22 = !DILocalVariable(name: "C", scope: !7, file: !1, line: 9, type: !12)
!23 = !DILocation(line: 9, column: 10, scope: !7)
!24 = !DILocation(line: 10, column: 11, scope: !7)
!25 = !DILocation(line: 10, column: 9, scope: !7)
!26 = !DILocation(line: 13, column: 12, scope: !7)
!27 = !DILocation(line: 13, column: 14, scope: !7)
!28 = !DILocation(line: 13, column: 3, scope: !7)
!29 = !DILocation(line: 14, column: 12, scope: !7)
!30 = !DILocation(line: 14, column: 14, scope: !7)
!31 = !DILocation(line: 14, column: 3, scope: !7)
!32 = !DILocation(line: 15, column: 12, scope: !7)
!33 = !DILocation(line: 15, column: 14, scope: !7)
!34 = !DILocation(line: 15, column: 3, scope: !7)
!35 = !DILocation(line: 16, column: 3, scope: !7)
