using View5D, Test

data1 = rand(5,5,3,2,2);
data2 = rand(5,5,3,2,2);
data3 = rand(5,5,3,4,2); # more elements

@testset "start viewers" begin
    @vv data1 # start the viewer
    @ve data2 # append along element
    @vt data3 # append along time
    @vt data3 # append along time
    @test 6 == get_num_times()
    @test 4 == get_num_elements()
    hide_viewer() 
end

@testset "interaction with markers" begin
    @vv data1 # start the viewer
    markers = empty_marker_list(2,2)
    markers[1][3]=1.0 
    markers[2][4]=2.0 
    markers[2][5]=1.0 
    markers[3][3]=3.0 
    markers[3][5]=2.0 
    markers[4][3]=1.5 
    markers[4][4]=1.5 
    markers[4][5]=2.0 
    import_marker_lists(markers)
    exported = export_marker_lists()
    mydiff = exported .- markers
    for d in 1:4
        @test mydiff[d][2:9] == zeros(8)
    end
    @test nothing != export_markers_string()
    delete_all_marker_lists()
end

data1 = rand(5,5,3,1,1) .+ 1im.*rand(5,5,3,1,1);
data2 = rand(5,5,3,1,1) .+ 1im.*rand(5,5,3,1,1);
data3 = rand(5,5,3,2,1) .+ 1im.*rand(5,5,3,2,1); # more elements

@testset "complex-valued display" begin
    @test nothing == @vp data1 # start a new viewer in phase mode
    @test nothing == set_gamma(1.0)
    @test nothing == @vep data2 # start a new viewer in phase mode
end

@testset "view5d datatypes" begin
    @test nothing != view5d(rand(Float32,2,2,2,2,2)) # -> float
    @test nothing != view5d(rand(Float64,2,2,2,2,2)) # -> double
    @test nothing != view5d(rand(ComplexF32,2,2,2,2,2)) # > Complex
    @test nothing != view5d(rand(ComplexF64,2,2,2,2,2)) # -> Complex
    @test nothing != view5d(rand(Int8,2,2,2,2,2)) # -> Byte
    @test nothing != view5d(rand(UInt8,2,2,2,2,2)) # -> Byte
    @test nothing != view5d(rand(Int16,2,2,2,2,2)) # -> Short (signed)
    @test nothing != view5d(rand(UInt16,2,2,2,2,2)) # -> Unsigned Short
    @test nothing != view5d(rand(Int32,2,2,2,2,2)) # -> int
    @test nothing != view5d(rand(UInt32,2,2,2,2,2)) # -> double
    @test nothing != view5d(rand(Int64,2,2,2,2,2)) # -> int
    @test nothing != view5d(rand(UInt64,2,2,2,2,2)) # -> int
    @test nothing == close_all()
    v = view5d(rand(Float32,2,2,2,2,2))
    @test nothing == set_gamma(1.0,v, element=0)
    @test nothing == set_display_size(400,500,v)
    @test nothing == set_fontsize(25,v)
    @test nothing == hide_viewer(v)
    @test nothing == to_front(v)
    @test nothing == set_value_unit("mm", v,element=1)
    @test nothing == set_min_max_thresh(0.0, 3.0, v,element=1)
    @test nothing == process_key_main_window('C', v)
    @test nothing == process_key_element_window('C', v)
    @test nothing == update_panels()
    @test nothing == set_time(0,v)
    @test nothing == set_element(0,v)
    @test nothing == set_times_linked(false,v)
    @test nothing == set_elements_linked(true,v)
    @test nothing == update_panels()
    @test nothing == close_all()
end
