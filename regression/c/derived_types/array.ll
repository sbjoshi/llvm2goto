; ModuleID = 'array.c'
source_filename = "array.c"
target datalayout = "e-m:e-i64:64-f80:128-n8:16:32:64-S128"
target triple = "x86_64-unknown-linux-gnu"

; Function Attrs: noinline nounwind optnone uwtable
define i32 @main() #0 !dbg !7 {
entry:
  %retval = alloca i32, align 4
  %a = alloca [10 x i32], align 16
  store i32 0, i32* %retval, align 4
  call void @llvm.dbg.declare(metadata [10 x i32]* %a, metadata !11, metadata !15), !dbg !16
  %arrayidx = getelementptr inbounds [10 x i32], [10 x i32]* %a, i64 0, i64 5, !dbg !17
  store i32 0, i32* %arrayidx, align 4, !dbg !18
  %arrayidx1 = getelementptr inbounds [10 x i32], [10 x i32]* %a, i64 0, i64 1, !dbg !19
  %0 = load i32, i32* %arrayidx1, align 4, !dbg !19
  %cmp = icmp eq i32 %0, 0, !dbg !20
  %conv = zext i1 %cmp to i32, !dbg !20
  %call = call i32 (i32, ...) bitcast (i32 (...)* @assert to i32 (i32, ...)*)(i32 %conv), !dbg !21
  ret i32 0, !dbg !22
}

; Function Attrs: nounwind readnone speculatable
declare void @llvm.dbg.declare(metadata, metadata, metadata) #1

declare i32 @assert(...) #2

attributes #0 = { noinline nounwind optnone uwtable "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-jump-tables"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }
attributes #1 = { nounwind readnone speculatable }
attributes #2 = { "correctly-rounded-divide-sqrt-fp-math"="false" "disable-tail-calls"="false" "less-precise-fpmad"="false" "no-frame-pointer-elim"="true" "no-frame-pointer-elim-non-leaf" "no-infs-fp-math"="false" "no-nans-fp-math"="false" "no-signed-zeros-fp-math"="false" "no-trapping-math"="false" "stack-protector-buffer-size"="8" "target-cpu"="x86-64" "target-features"="+fxsr,+mmx,+sse,+sse2,+x87" "unsafe-fp-math"="false" "use-soft-float"="false" }

!llvm.dbg.cu = !{!0}
!llvm.module.flags = !{!3, !4, !5}
!llvm.ident = !{!6}

!0 = distinct !DICompileUnit(language: DW_LANG_C99, file: !1, producer: "clang version 5.0.1 (tags/RELEASE_501/final)", isOptimized: false, runtimeVersion: 0, emissionKind: FullDebug, enums: !2)
!1 = !DIFile(filename: "array.c", directory: "/home/ubuntu/llvm2goto/regression/c/derived_types")
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
!12 = !DICompositeType(tag: DW_TAG_array_type, baseType: !10, size: 320, elements: !13)
!13 = !{!14}
!14 = !DISubrange(count: 10)
!15 = !DIExpression()
!16 = !DILocation(line: 2, column: 6, scope: !7)
!17 = !DILocation(line: 3, column: 2, scope: !7)
!18 = !DILocation(line: 3, column: 7, scope: !7)
!19 = !DILocation(line: 4, column: 9, scope: !7)
!20 = !DILocation(line: 4, column: 14, scope: !7)
!21 = !DILocation(line: 4, column: 2, scope: !7)
!22 = !DILocation(line: 5, column: 2, scope: !7)
